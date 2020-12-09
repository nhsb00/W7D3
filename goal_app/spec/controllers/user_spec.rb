require 'rails_helper'

RSpec.describe UsersController, type: :controller do 

    describe "GET #new" do
        it "Signing up to make a user" do
            allow(subject).to receive(:logged_in?).and_return(true)

            get :new
            expect(response).to render_template(:new) 
        end
    end

    describe "POST #create" do
        # before :each do
        #     create(:user)
        #     allow(subject).to receive(:current_user).and_return(User.last)
        # end
       
        let(:valid_params) { {user: {username: "Philip Kor", password: "onering"}} }
        let(:invalid_params) { {user: {username: "", password: ""}} }
        
        context "with valid params" do 
            before :each do
                post(:create, {params: valid_params})
            end

            it "creates the user" do
                expect(User.last.username).to eq('Philip Kor') 
            end
        
            it "redirects to users index" do
                expect(response).to have_http_status(302) 
                expect(response).to redirect_to(users_url) 
            end
        end
        
        context "with invalid params" do
            before(:each) { post :create, params: invalid_params }

            it "load new sign up page" do 
                expect(response).to have_http_status(200) 
                expect(response).to render_template(:new)
            end

            it "adds errors to flash" do
                expect(flash[:errors]).to be_present
            end
        end
    end

end