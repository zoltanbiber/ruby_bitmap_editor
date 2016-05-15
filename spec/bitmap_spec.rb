require './app/bitmap'

describe Bitmap do

	let(:width)		{ 5 }
	let(:height)	{ 6 }
	let(:bitmap)	{ Bitmap.new(width, height) }

	describe 'creating a bitmap instance' do
		it 'sets the bitmap width (number of columns) and height (number of rows)' do
			expect(bitmap.width).to eq(5)
			expect(bitmap.height).to eq(6)
		end

		it 'sets every pixel in the image as O colour' do
			expect(bitmap.pixels).to eq("OOOOO\nOOOOO\nOOOOO\nOOOOO\nOOOOO\nOOOOO\n")
		end
	end

	describe 'clearing the bitmap' do
		it 'resets every pixel colour to O' do
			bitmap.pixels = "OOCOO\nOOOOC\nGOOOO\nOOTOO\nOOIOO\nOOWOO\n"
			pixels_before_clear = bitmap.pixels

			bitmap.clear

			expect(pixels_before_clear).not_to eq(bitmap.pixels)
			expect(bitmap.pixels).to eq("OOOOO\nOOOOO\nOOOOO\nOOOOO\nOOOOO\nOOOOO\n")
		end
	end

	describe 'colouring a pixel' do
		it 'replaces the letter-code of the pixel with the letter specified' do
			bitmap.colour_pixel(3, 3, 'W')
			expect(bitmap.pixels).to eq("OOOOO\nOOOOO\nOOWOO\nOOOOO\nOOOOO\nOOOOO\n")

			bitmap.clear
			bitmap.colour_pixel(5, 6, 'R')
			expect(bitmap.pixels).to eq("OOOOO\nOOOOO\nOOOOO\nOOOOO\nOOOOO\nOOOOR\n")
		end
	end

	describe 'colouring a vertical segment' do
		it 'replaces the letter-codes of the pixel(s) in the specified columns and rows' do
			bitmap.colour_vertical_segment(3, 1, 6, 'M')
			expect(bitmap.pixels).to eq("OOMOO\nOOMOO\nOOMOO\nOOMOO\nOOMOO\nOOMOO\n")

			bitmap.colour_vertical_segment(5, 1, 3, 'F')
			expect(bitmap.pixels).to eq("OOMOF\nOOMOF\nOOMOF\nOOMOO\nOOMOO\nOOMOO\n")
		end
	end

	describe 'colouring a horizontal segment' do
		it 'replaces the letter-codes of the pixel(s) in the specified columns and rows' do
			bitmap.colour_horizontal_segment(1, 4, 1, 'W')
			expect(bitmap.pixels).to eq("WWWWO\nOOOOO\nOOOOO\nOOOOO\nOOOOO\nOOOOO\n")

			bitmap.colour_horizontal_segment(4, 5, 6, 'Q')
			expect(bitmap.pixels).to eq("WWWWO\nOOOOO\nOOOOO\nOOOOO\nOOOOO\nOOOQQ\n")
		end
	end
end
