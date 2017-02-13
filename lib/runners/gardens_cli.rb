class GardensCLI

    def call
      puts "Welcome to NYC's Backyard!"
      run
    end

    def get_user_input
      gets.chomp.strip.downcase
    end

    def normalize(input)
      input.split(' ').map { |word| word.capitalize}.join(" ")
    end

    def run
      puts "Search by 'neighborhood', 'borough', or 'garden name'?\n Enter 'help' or 'exit' for more info or to exit."
      search_for= get_user_input
      if search_for == "exit"
        exit
      elsif search_for == "help"
        help
      end
      while search_for != "neighborhood" && search_for != "borough" && search_for != "garden name"
        invalid_choice(search_for)
        run
      end
      puts"Which #{search_for}?"
      search = normalize(get_user_input)
      search_for = make_hash_key(search_for)
      if search_for == 'boro'
        search = make_hash_value(search)
      end
      result(make_url(search_for, search))
    end

    def make_hash_key(search_for)
      if search_for == "neighborhood"
        return "neighborhoodname"
      elsif search_for == "garden name"
        return "garden_name"
      else
        return "boro"
      end
    end

    def make_hash_value(value)
      case value
      when 'Manhattan'
        return 'M'
      when 'Brooklyn'
        return 'B'
      when 'Bronx'
        return 'X'
      when 'Queens'
        return 'Q'
      when 'Staten Island'
        return 'R'
      end
    end

    def make_url(search_for, search)
      "https://data.cityofnewyork.us/resource/yes4-7zbb.json?#{search_for}=#{search}"
    end

    def result(url)
      results=GetCommunityGardensAPI.new(url)
      results.make_object_add_to_array
      results_not_found(results.community_gardens)
      results.community_gardens.each do |garden|
        puts "Name: #{garden.name}\nAddress: #{garden.address}\nCross Streets: #{garden.cross_streets}"
        puts "=" * 30
      end
      try_again?

    end

    def results_not_found(results_array)
      if results_array.length < 1
        puts "We couldn't find any community gardens based on your search...\nPlease try again"
        run
      end
    end

    def try_again?
      puts "Would you like to try again? 'Y' or 'N'"
      response = gets.chomp.downcase
      if response=="y"
        run
      else
        exit
      end
    end

    def help
      puts "This is an application to help you find NYC Community Gardens.\n
            **********************************
            Type 'N' to exit or 'Y' to continue"
      input = gets.chomp.downcase
      if input == "y"
        run
      else
        exit
      end
    end

    def invalid_choice(search_for)
      puts"\n" +
      "*" * 30 + "\n" +
      "#{search_for} is an invalid choice, please try again" + "\n" +
      "*" * 30
    end
end
