class TeamsController < BaseController
  before_filter :set_race
  before_filter :guess_section
  before_filter :redirect_if_full, :only => [:new, :create]
  skip_before_filter :verify_authenticity_token, :only => :payment

  def index
    @teams = @race.teams.leader_board
    respond_to do |format|
      format.html
      format.js { render @teams, :layout => false }
    end
  end

  def show
    @team = @race.teams.find_by_position params[:position]
  end

  def new
    @team = @race.teams.build
    6.times { @team.riders << Rider.new }
  end

  def create
    @team = @race.teams.build params[:team]
    if @team.save
      RegistrationMailer.deliver_registration(@team)
      render :layout => false
    else
      until @team.riders.length == 6
        @team.riders << Rider.new
      end
      render :show
    end
  end

  def payment
    @team = Team.find params[:custom]
    @team.riders.each do |rider|
      rider.update_attributes :paid => true, :payment_type => "PayPal #{params[:txn_id]}"
    end
    render :nothing => true
  end

  private
    def redirect_if_full
      redirect_to "/join/articles/closed" if Rider.count >= 520
    end

    def set_race
      @race = Race.find_by_year params[:year] || Date.today.year
    end
end
