# Given an array of integers, calculate the factors in the array for each integer. 
# Output them in whatever format, but basically group each integer with their factors. 
# For example: Given [ 2, 3, 4, 6 ], the output would have {2: []},{4: [2]}, {6: [2, 3]}. 

# For additional challenge, implement a caching system that will provide the answers to a given array without performing the calculation again. 

# Version 1
# An array factor machine can
# be initialized with an array
# get and set a new array
# calculate the factors of that array
# return the results as a string

# Version 2
# An array factor machine can now
# load a CSV file of cached results
# sort the source array to ensure output is easy to cache
# when calculating the factors, first check the loaded CSV for a matching entry. If found, use that entry's result
# if the result is not found in the cache, perform the factor calculations and store this array and the result in the cache. Then write the cache back to the file

class ArrayFactorMachine
    def initialize(inArray = [])
        @sourceArray = inArray
        @factorString = ""
        @factorHash = {}
        @cacheFilePath = ""
    end

    def cacheFilePath
        @cacheFilePath
    end

    def setCacheFilePath(inFilePath)
        @cacheFilePath = inFilePath
    end

    def sourceArray
        @sourceArray
    end

    def setSourceArray(inArray = [])
        @sourceArray = inArray
        @factorString = ""
    end

    # for each number in the array, loop through each other number
    # if the outer loop number modulus the inner loop number is zero, then the inner loop number is a factor of the outer loop number
    # add each factor to an array
    # add an entry to the hash with the key as the outer number and the value is the array of factors
    def calculateFactors()
        @factorHash = {}
        @factorString = ""
        for i in 0...@sourceArray.length do
            tempArray = []
            for j in 0...@sourceArray.length do
                # don't compare the same number and don't modulus a zero
                if (i == j ||
                    @sourceArray[j] == 0)
                    next
                end
                # if i modulus j is 0, then j is a factor of i
                if (@sourceArray[i] % @sourceArray[j] == 0)
                    tempArray.append(@sourceArray[j])
                end
            end
            # add entry to the hash, i is the key and the array of factors is the value
            @factorHash[@sourceArray[i]] = tempArray
        end
        return @factorHash
    end

    # want the result like N1:[F1,F2,...F57];N2:[F1,F2,...F13]
    def factorString
        # don't return an empty array
        if (!@factorString.eql?(""))
            puts "@factorString is not blank"
            return @factorString
        end
        # for each key value pair
        @factorHash.each do |k, v|
            # start with the key, a colon, and the opening bracket
            @factorString += "#{k}:["
            # for each factor in the array
            v.each do |f|
                # append the factor and a comma
                @factorString += "#{f},"
            end
            # if there were any factors, then the final character is a comma. remove the last comma
            if (@factorString[@factorString.length - 1] == ",")
                @factorString.delete_suffix!(",")
            end
            # append the closing bracket and a semicolon
            @factorString += "];"
        end
        # if the string isn't empty after that, the last character is a semicolon. 
        if (@factorString.length > 0)
            @factorString.delete_suffix!(";")
        end
        return @factorString
    end


end