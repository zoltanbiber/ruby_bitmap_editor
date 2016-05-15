require_relative 'bitmap'
require 'byebug'

class BitmapEditor

  def run
    @running = true
    puts 'type ? for help'
    while @running
      print '> '
      input = gets.chomp.strip.upcase
      command, *args = input.split(' ').map{ |arg| (arg == "0" || arg.to_i != 0) ? arg.to_i : arg}

      if correct_input?(command, args)
        case command
          when 'I'
            @bitmap = Bitmap.new(*args[0,2])
          when 'C'
            @bitmap ? @bitmap.clear : puts("Bitmap doesn't exist. Cannot clear. Type '?' for help.")
          when 'L'
            @bitmap ? @bitmap.colour_pixel(*args[0,3]) : puts("Bitmap doesn't exist. Cannot colour pixel. Type '?' for help.")
          when 'V'
            @bitmap ? @bitmap.colour_vertical_segment(*args[0,4]) : puts("Bitmap doesn't exist. Cannot colour vertical segment. Type '?' for help.")
          when 'H'
            @bitmap ? @bitmap.colour_horizontal_segment(*args[0,4]) : puts("Bitmap doesn't exist. Cannot colour horizontal segment. Type '?' for help.")
          when 'S'
            @bitmap ? @bitmap.show : puts("Bitmap doesn't exist. Cannot show it. Type '?' for help.")
          when '?'
            show_help
          when 'X'
            exit_console
          else
            puts "Unrecognised command :(. Type '?' for help."
        end
      else
        puts @input_error
        show_help
      end
    end
  end

  private

  def correct_input?(command, args)
    if args.count == 1 || args.count > 4
      @input_error = "Commands should have 0,2,3 or 4 arguments separated by spaces."
      return false
    elsif args.any? { |a| a == 0 }
      @input_error = "None of the arguments can be 0."
      return false
    elsif command == 'I' && (args.count != 2 || !args.all? {|a| a.is_a?(Integer)})
      @input_error = "Command 'I' should have 2 arguments (numbers) separated by spaces."
      return false
    elsif command == 'L' && (args.count != 3 || !args[0,2].all? {|a| a.is_a?(Integer)} || args[2].is_a?(Integer) || args[2].length != 1)
      @input_error = "Command 'L' should have 3 arguments (two numbers and a letter) separated by spaces."
      return false
    elsif (command == 'V' || command == 'H') && (args.count != 4 || !args[0,3].all? {|a| a.is_a?(Integer)} || args[3].is_a?(Integer) || args[3].length != 1)
      @input_error = "Commands 'V' and 'H' should have 4 arguments (3 numbers and a letter) separated by spaces."
      return false
    end
    true
  end

  def exit_console
    puts 'goodbye!'
    @running = false
  end

  def show_help
    puts %q(
    ***** ? - Help *****

    I M N - Create a new M x N image with all pixels coloured white (O).
    C - Clears the table, setting all pixels to white (O).
    L X Y C - Colours the pixel (X,Y) with colour C.
    V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
    H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
    S - Show the contents of the current image
    X - Terminate the session)
  end
end
