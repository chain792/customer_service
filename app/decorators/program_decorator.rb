class ProgramDecorator < ApplicationDecorator
  delegate_all

  def application_start_time
    object.application_start_time.strftime("%Y-%m-%d %H:%M")
  end

  def application_end_time
    object.application_end_time.strftime("%Y-%m-%d %H:%M")
  end

  def max_number_of_participants
    if object.max_number_of_participants
      h.number_with_delimiter(object.max_number_of_participants)
    end
  end

  def min_number_of_participants
    if object.min_number_of_participants
      h.number_with_delimiter(object.min_number_of_participants)
    end
  end

  def number_of_applicants
    h.number_with_delimiter(object[:number_of_applicants])
  end

  def registrant
    object.registrant.family_name + " " + object.registrant.given_name
  end
end
