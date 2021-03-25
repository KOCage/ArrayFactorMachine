require './ArrayFactorMachine'
require 'csv'
require 'byebug'

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
            @afm.sourceArray = @testArray
            returnedArray = @afm.sourceArray
            # expect
            expect(returnedArray).to match(@testArray)
        end
        it "calculate the factors of that array and return the hash" do
            # arrange
            expectedResults = { 2 => [], 4 => [2], 6 => [2], 8 => [2,4], 10 => [2], 20 => [2,4,10] }
            @afm.sourceArray = @testArray
            # act
            returnedResults = @afm.calculateFactors
            # expect
            returnedResults.each do |k, v|
                expect(v).to match(expectedResults[k])
            end
        end
        it "return the results as a string" do
            # arrange
            expectedString = "2:[];4:[2];6:[2];8:[2, 4];10:[2];20:[2, 4, 10]"
            # act
            @afm.sourceArray = @testArray
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
            @afm.cacheFilePath = @cacheFilePath
            returnedPath = @afm.cacheFilePath
            # assert
            expect(returnedPath).to eq(@cacheFilePath)
        end
        it "load a CSV file of cached results" do
            # arrange
            # ensure that the csv file doesn't exist
            if (File.exists? @cacheFilePath)
                File.delete @cacheFilePath
            end
            # create the cache data
            cachedData = CSV.open(@cacheFilePath, 'w', write_headers: true, headers: ["sourceArray", "sourceFactors"])
            expectedFactors = "2:[];4:[2];6:[2];8:[2, 4];10:[2];20:[2, 4, 10]"
            # write the cache data to the CSV file
            cachedData << [@testArray, expectedFactors]
            cachedData.close
            cachedData = CSV.open(@cacheFilePath, 'r', headers: true)
            # read the cachedData CSV in to an array of arrays
            testData = cachedData.read
            cachedData.close
            # set the factor machine's csv file path
            @afm.cacheFilePath = @cacheFilePath
            # act
            # have the factor machine load the csv file and return it
            returnedCache = @afm.loadCacheFile
            # assert
            # for each row of the returned csv, ensure it matches the cachedData csv
            expect(returnedCache.count).to eq(testData.count)
            for i in 0...returnedCache.count
                expect(returnedCache[i]).to eq(testData[i])
            end
        end
        it "sort the source array in ascending order" do
            # arrange
            @afm.sourceArray = [20, 15, 16, 30, 25, 2, 10]
            expectedArray = [2, 10, 15, 16, 20, 25, 30]
            # act
            returnedArray = @afm.sourceArray
            # assert
            for i in 0...expectedArray.length
                expect(returnedArray[i]).to eq(expectedArray[i])
            end
        end
        it "find a cached result" do
            # arrange
            if (File.exists? @cacheFilePath)
                File.delete @cacheFilePath
            end
            # create the cache data
            cachedData = CSV.open(@cacheFilePath, 'w', write_headers: true, headers: ["sourceArray", "factors"])
            expectedFactors = "2:[];4:[2];6:[2];8:[2, 4];10:[2];20:[2, 4, 10]"
            # write the cache data to the CSV file
            cachedData << [@testArray, expectedFactors]
            cachedData.close
            # have the factor machine load the cache file
            @afm.cacheFilePath = @cacheFilePath
            @afm.loadCacheFile
            # act
            # have the machine search the cache for the test array
            cachedResult = @afm.getCachedResult(@testArray.to_s)
            # assert
            # expect returned result tp be equal to the expectedFactors
            expect(cachedResult).to eq(expectedFactors)
        end
        it "initialize a new cache file" do 
            # arrange
            # ensure the cache file is deleted
            if (File.exists? @cacheFilePath)
                File.delete @cacheFilePath
            end
            # set the factor machine's csv path
            @afm.cacheFilePath = @cacheFilePath
            # act
            @afm.initializeCacheCSV
            fileInitialized = File.exists? @cacheFilePath
            # assert
            expect(fileInitialized).to eq(true)
        end
        it "store newly calculated results in the cache file" do
            # arrange
            # prepare the expected factor results
            factors = "2:[];4:[2];6:[2];8:[2, 4];10:[2];20:[2, 4, 10]"
            # ensure the cache file is empty
            if (File.exists? @cacheFilePath)
                File.delete @cacheFilePath
            end
            # set the factor machine's csv path
            @afm.cacheFilePath = @cacheFilePath
            # set the factor machine's source array to @testArray
            @afm.sourceArray = @testArray
            # ensure the cacheFile has been initialized
            @afm.initializeCacheCSV
            # act
            # store the results
            @afm.storeCalculation(@testArray.to_s, factors)
            # read in the csv cache
            cacheCSV = CSV.open(@cacheFilePath, 'r', headers: true)
            # slurp all the data
            cacheData = cacheCSV.read
            # close the CSV
            cacheCSV.close
            # assert
            # expect the result of the factor calculation to be in the csv
            expect(cacheData[0][0]).to eq(@testArray.to_s)
            expect(cacheData[0][1]).to eq(factors)
        end
    end
end