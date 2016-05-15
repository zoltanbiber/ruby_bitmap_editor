class Bitmap
	attr_accessor :width, :height, :pixels

	def initialize(width, height)
		@width = width
		@height = height
		create_bitmap(@width, @height)
	end

	def clear
		@pixels = @pixels.gsub(/[A-Z]/, 'O')
	end

	def colour_pixel(x, y, colour)
		pixel_index = (y - 1) * (@width + 1) + (x - 1)
		existing_pixel?(x, y) ? @pixels[pixel_index] = colour : puts("Pixel #{x},#{y} doesn't exist. Bitmap size is #{@width}x#{@height}.")
	end

	def colour_vertical_segment(column, row_start, row_end, colour)
		(row_start..row_end).each {|row| colour_pixel(column, row, colour)}
	end

	def colour_horizontal_segment(column_start, column_end, row, colour)
		(column_start..column_end).each {|column| colour_pixel(column, row, colour)}
	end

	def show
		puts @pixels
		puts "Bitmap size is #{@width}x#{height}."
	end

	private

	def create_bitmap(width, height)
		@pixels = ''
		height.times do
			width.times do
				@pixels << 'O'
			end
			@pixels << "\n";
		end
		puts "#{width}x#{height} bitmap created."
	end

	def existing_pixel?(x, y)
		@width >= x && @height >= y ? true : false
	end
end
