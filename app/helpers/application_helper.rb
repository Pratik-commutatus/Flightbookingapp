module ApplicationHelper
    def readable_time(time)
        time.strftime("%I:%M%P") if time.present?
    end
end
