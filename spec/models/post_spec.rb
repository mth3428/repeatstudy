require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end

  describe "ツイートの保存" do
    context "ツイートが保存できる場合" do
      it "画像とテキストがあればツイートは保存される" do
        expect(@post).to be_valid
      end
      it "テキストのみあればツイートは保存される" do
        @post.image = ''
        expect(@post).to be_valid
      end
    end
    context "ツイートが保存できない場合" do
      it "テキストがないとツイートは保存できない" do
        @post.tweet = ''
        @post.valid?
        expect(@post.errors.full_messages).to include "Tweetを入力してください"
      end     
      it "ユーザーが紐付いていないとツイートは保存できない" do
        @post.user = nil
        @post.valid?
        expect(@post.errors.full_messages).to include "Userを入力してください"
      end
    end
  end
end
