class Api::V1::ContactsController < Api::V1::ApiController

  before_action :set_contact, only: [:show, :update, :destroy]
  before_action :require_authorization!, only: [:show, :update, :destroy]
 
  def index
    @contacts = Contact.where(:user_id => current_user).paginate(page: params[:page], per_page: 5)
    render json: @contacts, include: 'addresses'
  end
 
  def show
    render json: @contact, include: 'addresses'
  end
 
  def create
    @contact = Contact.new(contact_params.merge(user: current_user))
    if @contact.save
      render json: @contact, status: :created
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end
 
  def update
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end
 
  def destroy
    @contact.destroy
  end
 
  private

    def set_contact
      @contact = Contact.find(params[:id])
    end
 
    def contact_params
      params.require(:contact).permit(:name, :email, :phone, :description, addresses_attributes: [:id, :street, :city, :state, :country, :code])
    end
 
    def require_authorization!
      unless current_user == @contact.user
        render json: {}, status: :forbidden
      end
    end
 
end