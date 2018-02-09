# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   Character.create(name: 'Luke', movie: movies.first)



train_links = {
"1"=>1,
"2"=>1,
"3"=>1,
"4"=>1,
"5"=>1,
"6"=>1,
"S"=>1,
"A"=>26,
"C"=>26,
"E"=>26,
"N"=>16,
"Q"=>16,
"R"=>16,
"W"=>16,
"B"=>21,
"D"=>21,
"F"=>21,
"M"=>21,
"L"=>2,
"G"=>31,
"J"=>36,
"Z"=>36,
"7"=>51
}


train_links.each do |k,v|
  Train.create(line: k, Mta_Id: v)
end
