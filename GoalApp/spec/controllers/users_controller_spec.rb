require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe "GET#index" do
        it "renders user index" do 
            get :index
            expect(response).to render_template(:index)
        end
    end

    describe "GET#new" do 
        it "brings up the form to create new user" do
            allow(subject).to receive(:logged_in?).and_return(true)
            get :new
            expect(response).to render_template(:new)
        end
    end

    describe "POST#create" do
        let (:valid_params){{user:{username: "Goldenfish", password: "flowerpower"}}}
        let (:invalid_params){{user:{faceman: "enfish", password: "t"}}}

        context "with valid params" do
            before(:each) {post :create, params: valid_params}

            it "should save a new user to the data base" do
                expect(User.last.username).to eq("Goldenfish")
            end

            it "redirects to user's index" do 
                expect(response).to redirect_to(user_url(User.last.id))
            end
        end

        context "with invalid params" do
            before(:each) {post :create, params: invalid_params}

            it "should stay on page despite error" do 
                expect(response).to have_http_status(200)
                expect(response).to render_template(:new)
            end

            it "adds error to the flash" do
                expect(flash[:errors]).to be_present
            end
        end
    end

    describe "DELETE#destory" do
        let(:user1){create(:user)}
        before(:each) do 
            # debugger
            delete :destroy, params: {id: user1.id}
        end

        it "should delete the user" do
            expect(User.exists?(user1.id)).to be (false)
        end

        it "should redirect to user index" do
            expect(response).to have_http_status(302)
            expect(response).to redirect_to(users_url)
        end
    end



end