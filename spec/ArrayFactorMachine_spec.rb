require './ArrayFactorMachine'

RSpec.describe "An ArrayFactorMachine can:" do 
    before do
        @afm = ArrayFactorMachine.new
        @testArray = [ 2, 4, 6, 8, 10, 20]
        @cacheFilePath = "E:/Code Ground/Code Challenges/ArrayFactorMachine/cache.csv"
    end

    context "Version 1" do
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

    
    # An array factor machine can now
    # get set a cache file location
    # load a CSV file of cached results
    # sort the source array to ensure output is easy to cache
    # find and use a cached result
    # store calculated results in the cache file
    context "Version 2" do
        it "get and set the csv location" do
            # arrange
            # act
            @afm.setCacheFilePath(@cacheFilePath)
            returnedPath = @afm.cacheFilePath
            # assert
            expect(returnedPath).to eq(@cacheFilePath)
        end
        it "load a CSV file of cached results" do
            skip "is skipped" do
            end
            # arrange
            # act
            # assert
        end
        it "sort the source array in ascending order" do
            skip "is skipped" do
            end
            # arrange
            # act
            # assert
        end
        it "find and use a cached result" do
            skip "is skipped" do
            end
            # arrange
            # act
            # assert
        end
        it "store newly calculated results in the cache file" do
            skip "is skipped" do
            end
            # arrange
            # act
            # assert
        end
    end


end