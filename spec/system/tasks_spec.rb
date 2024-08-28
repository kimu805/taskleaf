require "rails_helper"

describe "タスク管理機能", type: :system do

  describe "新規作成機能" do
    before do
      @user = FactoryBot.create(:user)
      @task = FactoryBot.build(:task, user: @user)
    end

    context "上手くいく場合" do
      it "ユーザーに紐づいたタスクを作成できる" do
        sign_in(@user)
        expect(page).to have_content("新規登録")
        click_on "新規登録"
        fill_in "名称", with: @task.name
        fill_in "詳しい説明", with: @task.description
        expect{
          click_on "登録する"
          sleep 1
        }.to change {@user.tasks.count}.by(1)
        expect(page).to have_content(@task.name)
      end
    end
    context "上手くいかない場合" do
      it "名称が空では登録できない" do
        sign_in(@user)
        click_on "新規登録"
        fill_in "詳しい説明", with: @task.description
        expect{
          click_on "登録する"
          sleep 1
        }.to change {@user.tasks.count}.by(0)
        expect(page).to have_current_path(new_task_path)
      end
    end
  end

  describe "一覧表示機能" do
    before do
      @user = FactoryBot.create(:user)
      @task = FactoryBot.create(:task, user: @user)
    end

    context "上手くいく場合" do
      it "ユーザーに紐づいたタスクが表示される" do
        sign_in(@user)
        expect(page).to have_content(@task.name)
      end
      it "他のユーザーが作成したタスクが表示されない" do
        another_user = FactoryBot.create(:user, name: "test2", email: "test2@test.com")
        another_task = FactoryBot.create(:task, user: another_user)
        sign_in(@user)
        expect(page).to have_no_content(another_task)
      end
    end
  end

  describe "詳細表示機能" do
    before do
      @user = FactoryBot.create(:user)
      @task = FactoryBot.create(:task, user: @user)
    end

    context "上手くいく場合" do
      it "ログインユーザーが作成したタスクが表示される" do
        sign_in(@user)
        expect(page).to have_content(@task.name)
        click_on @task.name
        expect(page).to have_content(@task.id)
      end
    end
  end
end