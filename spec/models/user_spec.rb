require 'rails_helper'

RSpec.describe User, type: :model do
  describe "ユーザー新規登録" do
    context "登録できないとき" do
      it "nicknameが空だと登録できない" do
        user = FactoryBot.build(:user)
        user.nickname = ""
        user.valid?
        expect(user.errors.full_messages).to include "ニックネームを入力してください"
      end
      it "emailが空では登録できない" do
      end
      it "introductionが空では登録できない" do
      end
    end
  end
end
