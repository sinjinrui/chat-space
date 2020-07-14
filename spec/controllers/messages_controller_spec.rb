require 'rails_helper'

describe MessagesController do
# 初回呼び出し時に実行 => 実行された後は常に同じ値が帰ってくる
  let(:group) { create(:group) }
  let(:user) { create(:user) }
  
  describe "#index" do
    context "log in" do
      
      before do
        login user
        get :index, params: { group_id: group.id }
      end
      # この中にログイン中のテストを記述
    # アクション内で定義しているインスタンス変数があるか
      it 'assigns @message' do
        expect(assigns(:message)).to be_a_new(Message)  
      end

      it 'assigns @group' do
        expect(assigns(:group)).to eq group  
      end
    # 該当するビューが描画されているか
      it 'renders index' do
        expect(response).to render_template :index  
      end
    end
    
    context "not log in" do
      before do
        get :index, params: {group_id: group.id}
      end
      # この中にログアウト中のテストを記述
      # 意図したビューにリダイレクトできているか
      it 'redirects to new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)  
      end
    end
    
    
  end
  
  describe '#create' do
    let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }
    
    context "log in" do
      before do
        login user
      end

      context "can save" do
        subject { 
          post :create,
          params: params
         } 
        #  メッセージの保存はできたか
         it 'count up message' do
          # change以降 => Messageモデルのレコードが１個増えたかどうか
           expect{ subject }.to change(Message, :count).by(1)
         end
        #  意図した画面に遷移しているか
         it 'redirects to group_messages_path' do
           subject
           expect(response).to redirect_to(group_messages_path(group))
         end
      end

      context 'can not save' do
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, text: nil, image: nil) } }

        subject {
          post :create,
          params: invalid_params
        }

        it 'does not count up' do
          expect{ subject }.not_to change(Message, :count)
        end

        it 'renders index' do
          subject
          expect(response).to render_template :index
        end
      end
    end

    context "not log in" do

      it 'redirects to new_user_session_path' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end