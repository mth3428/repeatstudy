require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end
  describe "コメントの保存" do
    context "コメントが保存できるとき" do
      it "コメントがあれが保存することができる" do
        expect(@comment).to be_valid
      end
    end
    context "コメントが保存できないとき" do
      it 'textカラムが空の場合コメントは保存できない' do
        @comment.message = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include "Messageを入力してください"
      end
      it 'ユーザーが紐付いていないとコメントは保存できない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include "Userを入力してください"
      end
      it 'ツイートが紐付いていないとコメントは保存できない' do
        @comment.post = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include "Postを入力してください"
      end
    end
  end
end
