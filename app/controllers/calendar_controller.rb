class CalendarController < ApplicationController

		def show
				@user=User.find(params[:id])
				events=Array.new
				@user.to_do_lists.each do |list|
					unless list.schedule_sta.nil?
						event=Hash.new
						event[:title] = list.title
						event[:start] = list.schedule_sta
						event[:end] = list.schedule_end
						event[:id] = list.id
						events << event
					end
				end
				render :json => events
		end

		def update
				@user=User.find(params[:id])
				@to_do_list=ToDoLists.find_by(id: event[:id])
				if @to_do_list.update_attributes(to_do_list_params)
						redirect_to root_url
				else
						render 'static_pages/home'
				end
		end

		private

		def to_do_list_params
				params.require(:to_do_list).permit(:title, :category_id, :priority_flg, :schedule_sta, :schedule_end, :comment, :ending_flg, :reminder_mail, :picture)
		end

end
