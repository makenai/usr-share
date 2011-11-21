require 'csv'

class MembersController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :authenticate_admin!, :only => [ :edit, :update, :destroy, :index ]
  
  def index
    if params[:new]
      @members = Member.where("card_number IS NULL or card_number = ''")
    else
      @members = Member.all
    end
    respond_to do |format|
      format.html
      format.csv do
        csv = CSV.generate do |csv|
          csv << [ 'name', 'email', 'number' ]
          @members.each do |member|
            csv << [ member.name.to_s.downcase.gsub(/\s+/,'.'), member.user.email, member.card_number ]
          end
        end
        send_data( csv, :filename => 'members.csv', :type => 'text/csv' )
      end
    end
  end

  def show
    @member = Member.find(params[:id])
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(params[:member])
    @member.user_id = current_user.id
    if @member.save
      redirect_to new_member_path, :notice => "Successfully created member."
    else
      render :action => 'new'
    end
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update_attributes(params[:member])
      if @member.send_pickup_email
        UserMailer.pickup_email(@member.user).deliver
      end
      redirect_to @member, :notice  => "Successfully updated member."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to members_url, :notice => "Successfully destroyed member."
  end
end
