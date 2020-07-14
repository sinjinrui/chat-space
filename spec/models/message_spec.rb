require 'rails_helper'
describe User do
  describe '#create' do
  # ここから保存できるパターン
    context 'can be save' do
  # メッセージがあれば保存できる
      it "is valid with text" do
        expect(build(:message, image: nil)).to be_valid  
      end
  # 画像があれば保存できる
      it "is valid with image" do
        expect(build(:message, text: nil)).to be_valid  
      end
  # メッセージと画像があれば保存できる
      it "is valid with text, image" do
        expect(build(:message)).to be_valid  
      end

    end
    context 'can not save' do
# メッセージも画像もないと保存できない
  # エラー文を日本語化しているため、includeから先を日本語にする
      it "is invalid without a text and image" do
        message = build(:message, text: nil, image: nil)
        message.valid?
        expect(message.errors[:text]).to include("を入力してください")
      end
  # group_idは無いと保存できない
      it "is invalid without  group_id" do
        message = build(:message, group_id: nil)
        message.valid?
        expect(message.errors[:group]).to include("を入力してください")
      end
  # user_idが無いと保存できない
      it "is invalid without  user_id" do
        message = build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user]).to include("を入力してください")
      end
    end
  end
end