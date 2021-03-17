require './ArrayFactorMachine'

RSpec.describe "An ArrayFactorMachine can:" do 
    before do
        @afm = ArrayFactorMachine.new
        @testArray = [ 2, 4, 6, 8, 10, 20]
    end

    # An array factor machine can
    # be initialized with an array
    # get and set a new array
    # calculate the factors of that array
    # return the results as a string
    it "be initialized with an array" do
        # arrange
        @afm = ArrayFactorMachine.new(@testArray)
        # act
        returnedArray = @afm.sourceArray
        # expect
        expect(returnedArray).to match(@testArray)
    end
    it "get and set a new array" do
        # arrange
        # act
        @afm.setSourceArray(@testArray)
        returnedArray = @afm.sourceArray
        # expect
        expect(returnedArray).to match(@testArray)
    end
    it "calculate the factors of that array and return the hash" do
        # arrange
        expectedResults = { 2 => [], 4 => [2], 6 => [2], 8 => [2,4], 10 => [2], 20 => [2,4,10] }
        @afm.setSourceArray(@testArray)
        # act
        returnedResults = @afm.calculateFactors
        # expect
        returnedResults.each do |k, v|
            expect(v).to match(expectedResults[k])
        end
    end
    it "return the results as a string" do
        # arrange
        expectedString = "2:[];4:[2];6:[2];8:[2,4];10:[2];20:[2,4,10]"
        # act
        @afm.setSourceArray(@testArray)
        resultingHash = @afm.calculateFactors
        resultingString = @afm.factorString
        # expect
        expect(resultingString).to eq(expectedString)
    end
end