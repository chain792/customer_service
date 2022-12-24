staff_members = StaffMember.order(:id)

20.times do |n|
  t = (18 - n).weeks.ago.midnight
  Program.create!(
    title: "プログラムNo.#{n + 1}",
    description: "会員向け特別プログラムです。" * 10,
    application_start_date: t.to_date,
    application_end_date: t.advance(days: 7).to_date,
    registrant: staff_members.sample
  )
end
