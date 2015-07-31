require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'
require 'awesome_print'
require 'sinatra'
require 'httparty'

response_2010 = open 'http://hackny.org/a/2010/06/announcing-the-2010-hackny-fellows/'
response_2011 = open 'http://hackny.org/a/2011/06/class-of-2011-hackny-fellows/'
response_2012 = open 'http://hackny.org/a/2012/06/class-of-2012-hackny-fellows/'
response_2013 = open 'http://hackny.org/a/2013/06/hackny-announces-the-class-of-2013-hackny-fellows/'
response_2014 = open 'http://hackny.org/a/2014/07/hackny-2014-fellowship-demofest-and-class-announcement/'
response_2015 = open 'http://hackny.org/a/2015/06/announcing-the-class-of-2015-hackny-fellows/'

class2010_document = Nokogiri::HTML response_2010 
class2011_document = Nokogiri::HTML response_2011
class2012_document = Nokogiri::HTML response_2012
class2013_document = Nokogiri::HTML response_2013
class2014_document = Nokogiri::HTML response_2014
class2015_document = Nokogiri::HTML response_2015

fellow_rows_2010 = class2010_document.css 'tr'
fellow_rows_2011 = class2011_document.css 'tr'
fellow_rows_2012 = class2012_document.css 'tr'
fellow_rows_2013 = class2013_document.css 'tr'
fellow_rows_2014 = class2014_document.css 'tr'
fellow_rows_2015 = class2015_document.css 'tr td'

#ap fellow_rows_2015

poke_number = 0

# 2010!!
fellow_hashes_2010 = fellow_rows_2010.map do |fellow_row|
	row_data = fellow_row.children.select do |child|
		child.text != "\n" 
	end 

	logo_img, company_td, student_td, university_td = row_data 

	# parse from the row
	student_name = defined?(student_td.children.name) ? student_td.children.children.text : student_td.children.text
	# company_name = company_td.children.children.text
	university_name = university_td.children.text

	{
		# company: company_name,
		name: student_name,
		university: university_name
	}
end

# 2011!!
fellow_hashes_2011 = fellow_rows_2011.map do |fellow_row|
	row_data = fellow_row.children.select do |child|
		child.text != "\n" 
	end 

	student_td, university_td, company_td= row_data 

	student_name = student_td.children.text
	university_name = university_td.children.text
	# company_name = company_td.children.children[1].attributes["alt"].value

	{
		# company: company_name,
		name: student_name,
		university: university_name
	}
end

# 2012!!
fellow_hashes_2012 = fellow_rows_2012.map do |fellow_row|
	row_data = fellow_row.children.select do |child|
		child.text != "\n" 
	end

	student_td, university_td = row_data

	student_name = student_td.children.children.children.text
	university_name = university_td.children.children.children.text

	{
		# company: company_name,
		name: student_name,
		university: university_name
	}
end


# 2013!!
fellow_hashes_2013 = fellow_rows_2013.map do |fellow_row|
	row_data = fellow_row.children.select do |child|
		child.text != "\n"
		# defined?(child.name) ? child.name != "th" : child.text != "\n"
	end

	student_td, university_td = row_data

	student_name = student_td.name != "th" ? student_td.children.children[1].text : ""
	university_name = university_td.name != "th" ? university_td.children.text : ""

	# remove newline
	student_name[0] = ""

	
	{
		# company: company_name,
		name: student_name,
		university: university_name
	}
end

# 2014!!
fellow_hashes_2014 = fellow_rows_2014.map do |fellow_row|
	row_data = fellow_row.children.select do |child|
		child.text != "\n"
	end

	student_td, university_td = row_data
	student_name = student_td.children.text
	university_name = university_td.children.text

	{
		# company: company_name,
		name: student_name,
		university: university_name
	}
end

# 2015!!
fellow_hashes_2015 = fellow_rows_2015[0...-2].map do |fellow_row, index|
	row_data = fellow_row.css("p").select do |child|
		child.text != ""
	end

	student_p, university_p = row_data
	student_name = student_p.text
	university_name = university_p.text

	{
		# company: company_name,
		name: student_name,
		university: university_name
	}
end


fellow_hashes_2013.slice!(0); # delete empty header
fellow_hashes_2014.slice!(0); # delete empty header

fellow_2010 = fellow_hashes_2010.sort_by do |fellow|
	fellow[:name]
end
fellow_2010 = fellow_2010.map do |fellow|
	poke_number += 1
	# fellow.merge!("number" => poke_number)
	response = HTTParty.get('http://pokeapi.co/api/v1/pokemon/' + poke_number.to_s + '/');
	fellow.merge!("pokemon" => response["name"])
end

fellow_2011 = fellow_hashes_2011.sort_by do |fellow|
	fellow[:name]
end
fellow_2011 = fellow_2011.map do |fellow|
	poke_number += 1
	# fellow.merge!("number" => poke_number)
	response = HTTParty.get('http://pokeapi.co/api/v1/pokemon/' + poke_number.to_s + '/');
	fellow.merge!("pokemon" => response["name"])
end

fellow_2012 = fellow_hashes_2012.sort_by do |fellow|
	fellow[:name]
end
fellow_2012 = fellow_2012.map do |fellow|
	poke_number += 1
	# fellow.merge!("number" => poke_number)
	response = HTTParty.get('http://pokeapi.co/api/v1/pokemon/' + poke_number.to_s + '/');
	fellow.merge!("pokemon" => response["name"])
end

fellow_2013 = fellow_hashes_2013.sort_by do |fellow|
	fellow[:name]
end
fellow_2013 = fellow_2013.map do |fellow|
	poke_number += 1
	# fellow.merge!("number" => poke_number)
	response = HTTParty.get('http://pokeapi.co/api/v1/pokemon/' + poke_number.to_s + '/');
	fellow.merge!("pokemon" => response["name"])
end

fellow_2014 = fellow_hashes_2014.sort_by do |fellow|
	fellow[:name]
end
fellow_2014 = fellow_2014.map do |fellow|
	poke_number += 1
	# fellow.merge!("number" => poke_number)
	response = HTTParty.get('http://pokeapi.co/api/v1/pokemon/' + poke_number.to_s + '/');
	fellow.merge!("pokemon" => response["name"])
end


fellow_2015 = fellow_hashes_2015.map do |fellow|
	poke_number += 1
	# fellow.merge!("number" => poke_number)
	response = HTTParty.get('http://pokeapi.co/api/v1/pokemon/' + poke_number.to_s + '/');
	fellow.merge!("pokemon" => response["name"])
end

all_fellows = fellow_2010.concat(fellow_2011).concat(fellow_2012).concat(fellow_2013).concat(fellow_2014).concat(fellow_2015)

get '/fellows.json' do
	all_fellows.to_json
end