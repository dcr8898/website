class FixFilePaths < ActiveRecord::Migration[6.1]
  def change
    Submission.destroy_all

    solution = Solution::Create.(
      User.find_by(handle: 'erikschierboom'),
      Track.find_by(slug: 'csharp').practice_exercises.find_by!(slug: 'hello-world')
    )
    submission = Submission.create!(
      solution: solution,
      uuid: SecureRandom.uuid,
      submitted_via: "cli"
    )
    
    # files = [
    #   "/haskell/atbash-cipher/Atbash.hs", "/haskell/bank-account/BankAccount.hs", "/haskell/beer-song/Beer.hs", "/haskell/binary-search-tree/BST.hs", "/haskell/clock/Clock.hs", "/haskell/crypto-square/CryptoSquare.hs", "/haskell/custom-set/CustomSet.hs", "/haskell/difference-of-squares/Squares.hs", "/haskell/food-chain/FoodChain.hs", "/haskell/forth/Forth.hs", "/haskell/hexadecimal/Hexadecimal.hs", "/haskell/house/House.hs", "/haskell/kindergarten-garden/Garden.hs", "/haskell/largest-series-product/Series.hs", "/haskell/linked-list/Deque.hs", "/haskell/luhn/Luhn.hs", "/haskell/matrix/Matrix.hs", "/haskell/meetup/Meetup.hs", "/haskell/minesweeper/Minesweeper.hs", "/haskell/nth-prime/Prime.hs", "/haskell/ocr-numbers/OCR.hs", "/haskell/octal/Octal.hs", "/haskell/palindrome-products/Palindromes.hs", "/haskell/pascals-triangle/Triangle.hs", "/haskell/pig-latin/PigLatin.hs", "/haskell/prime-factors/PrimeFactors.hs", "/haskell/pythagorean-triplet/Triplet.hs", "/haskell/queen-attack/Queens.hs", "/haskell/raindrops/Raindrops.hs", "/haskell/robot-name/Robot.hs", "/haskell/robot-simulator/Robot.hs", "/haskell/roman-numerals/Roman.hs", "/haskell/saddle-points/Matrix.hs", "/haskell/scrabble-score/Scrabble.hs", "/haskell/triangle/Triangle.hs", "/haskell/trinary/Trinary.hs", "/haskell/wordy/WordProblem.hs", "/scala/accumulate/src/main/scala/Accumulate.scala", "Accumulate.cs", "Accumulate.elm", "Accumulate.fs", "Accumulate.hs", "Accumulate.scala", "Acronym.elm", "AffineCipher.fs", "AllYourBase.elm", "Allergies.cs", "Allergies.elm", "Allergies.fs", "Allergies.scala", "Alphametics.cs", "Anagram.cs", "Anagram.elm", "Anagram.hs", "Anagram.scala", "AnnalynsInfiltration.cs", "ArmstrongNumbers.fs", "Atbash.cs", "Atbash.scala", "AtbashCipher.elm", "BankAccount.cs", "BankAccount.fs", "BankAccount.scala", "Beer.cs", "BeerSong.fs", "Binary.cs", "Binary.scala", "BinarySearch.cs", "Bob.cs", "Bob.elm", "Bob.fs", "Bob.hs", "BookStore.cs", "Bst.scala", "CarsAssemble.cs", "Cipher.cs", "Clock.cs", "Clock.fs", "Clock.scala", "CollatzConjecture.cs", "CollatzConjecture.elm", "CollatzConjecture.fs", "Complement.cs", "ComplexNumbers.cs", "ComplexNumbers.fs", "Crypto.cs", "CryptoSquare.scala", "DNA.cs", "DNA.hs", "DNA.scala", "Darts.fs", "Deque.cs", "DifferenceOfSquares.elm", "DifferenceOfSquares.fs", "Dna.scala", "DndCharacter.cs", "ETL.cs", "ETL.hs", "ETL.scala", "EnumerableExtensions.cs", "ErrorHandling.cs", "Etl.elm", "Example.cs", "Example.fs", "Garden.cs", "Garden.scala", "Gigasecond.cs", "Gigasecond.elm", "Gigasecond.fs", "Gigasecond.hs", "Gigasecond.scala", "GradeSchool.cs", "GradeSchool.elm", "Grains.elm", "Grains.fs", "Grains.hs", "Grains.scala", "Hamming.cs", "Hamming.elm", "Hamming.fs", "Hamming.hs", "Hamming.scala", "HelloWorld.cs", "HelloWorld.elm", "Hexadecimal.scala", "HighScores.cs", "HighScores.fs", "IntExtensions.cs", "IsbnVerifier.fs", "Isogram.cs", "Isogram.elm", "KindergartenGarden.cs", "LargestSeriesProduct.cs", "LargestSeriesProduct.elm", "Leap.cs", "Leap.elm", "LeapYear.fs", "LeapYear.hs", "LinkedList.hs", "ListOps.elm", "ListOps.hs", "LuciansLusciousLasagna.cs", "Luhn.cs", "Luhn.scala", "Markdown.cs", "Matrix.scala", "Meetup.cs", "Meetup.scala", "Minesweeper.cs", "NucleotideCount.cs", "NucleotideCount.elm", "Octal.cs", "Pangram.elm", "PascalsTriangle.cs", "Person.hs", "Phone.hs", "PhoneNumber.cs", "PhoneNumber.elm", "PhoneNumber.scala", "Phrase.cs", "Phrase.scala", "PigLatin.cs", "PrimeFactors.cs", "PrimeFactors.scala", "Queen.cs", "Queens.scala", "RNATranscription.elm", "Raindrops.cs", "Raindrops.elm", "Raindrops.scala", "RationalNumbers.cs", "Rectangles.cs", "ResistorColorDuo.cs", "ResistorColorTrio.cs", "RestApi.cs", "RestApi.fs", "ReverseString.cs", "ReverseString.fs", "Robot.cs", "Robot.hs", "Robot.scala", "RobotName.fs", "RobotSimulator.elm", "RomanNumeral.scala", "RomanNumerals.elm", "RotationalCipher.fs", "RunLengthEncoding.elm", "SaddlePoints.cs", "Say.elm", "School.cs", "School.hs", "School.scala", "Scrabble.cs", "Scrabble.scala", "ScrabbleScore.elm", "SecretHandshake.cs", "Series.cs", "Series.elm", "Series.scala", "Sieve.cs", "SpaceAge.cs", "SpaceAge.elm", "SpaceAge.fs", "SpaceAge.hs", "SpaceAge.scala", "Squares.cs", "Squares.scala", "Strain.cs", "Strain.elm", "Strain.hs", "Sublist.elm", "Sublist.hs", "Sublist.scala", "SumOfMultiples.cs", "SumOfMultiples.elm", "SumOfMultiples.fs", "SumOfMultiples.hs", "Transpose.cs", "Transpose.elm", "Triangle.cs", "Triangle.elm", "Triangle.fs", "Triangle.scala", "Trinary.cs", "Triplet.cs", "TwelveDays.elm", "TwelveDaysSong.cs", "TwoFer.cs", "TwoFer.elm", "TwoFer.fs", "WordCount.elm", "WordCount.hs", "WordProblem.cs", "Yacht.fs", "Year.cs", "Year.scala", "\\\\Accumulate.cs", "\\\\Acronym.cs", "\\\\AffineCipher.cs", "\\\\ArmstrongNumbers.cs", "\\\\BinarySearch.elm", "\\\\BracketPush.cs", "\\\\BracketPush.elm", "\\\\Clock.cs", "\\\\ComplexNumbers.cs", "\\\\Darts.cs", "\\\\DndCharacter.fs", "\\\\Dominoes.fs", "\\\\IsbnVerifier.cs", "\\\\Leap.cs", "\\\\Luhn.elm", "\\\\RationalNumbers.fs", "\\\\ResistorColor.cs", "\\\\RotationalCipher.cs", "\\\\SpiralMatrix.cs", "\\\\SpiralMatrix.fs", "\\\\Yacht.cs", "\\\\accumulate.ts", "\\\\all-your-base.ts", "\\\\allergies.ts", "\\\\armstrong-numbers.js", "\\\\armstrong-numbers.ts", "\\\\beer-song.ts", "\\\\bob.ts", "\\\\bracket-push.ts", "\\\\circular-buffer.ts", "\\\\collatz-conjecture.js", "\\\\collatz-conjecture.ts", "\\\\complex-numbers.js", "\\\\complex-numbers.ts", "\\\\connect.js", "\\\\connect.ts", "\\\\crypto-square.ts", "\\\\custom-set.ts", "\\\\difference-of-squares.ts", "\\\\diffie-hellman.js", "\\\\diffie-hellman.ts", "\\\\etl.ts", "\\\\flatten-array.ts", "\\\\food-chain.ts", "\\\\gigasecond.ts", "\\\\grade-school.ts", "\\\\hamming.ts", "\\\\hello-world.ts", "\\\\hello_world.exs", "\\\\hello_world.go", "\\\\house.js", "\\\\house.ts", "\\\\isbn-verifier.js", "\\\\isogram.ts", "\\\\leap.exs", "\\\\leap.ts", "\\\\list-ops.js", "\\\\list-ops.ts", "\\\\matrix.rb", "\\\\meetup.rb", "\\\\minesweeper.js", "\\\\minesweeper.ts", "\\\\nucleotide-count.js", "\\\\nucleotide-count.ts", "\\\\ocr-numbers.ts", "\\\\palindrome-products.ts", "\\\\pangram.ts", "\\\\perfect-numbers.js", "\\\\pig-latin.ts", "\\\\pig_latin.rb", "\\\\protein-translation.js", "\\\\protein-translation.ts", "\\\\queen-attack.ts", "\\\\raindrops.rb", "\\\\raindrops.ts", "\\\\rectangles.js", "\\\\rectangles.ts", "\\\\resistor_color_duo.rb", "\\\\reverse-string.js", "\\\\reverse-string.ts", "\\\\rna-transcription.js", "\\\\rna-transcription.ts", "\\\\robot-name.ts", "\\\\rotational-cipher.js", "\\\\rotational-cipher.ts", "\\\\run-length-encoding.js", "\\\\run-length-encoding.ts", "\\\\saddle-points.ts", "\\\\scrabble-score.ts", "\\\\series.rb", "\\\\simple-cipher.ts", "\\\\simple-linked-list.js", "\\\\spiral-matrix.js", "\\\\src\\\\hello_world.clj", "\\\\src\\\\lib.rs", "\\\\src\\\\main\\\\kotlin\\\\Acronym.kt", "\\\\src\\\\main\\\\kotlin\\\\BankAccount.kt", "\\\\src\\\\main\\\\kotlin\\\\Bob.kt", "\\\\src\\\\main\\\\kotlin\\\\Clock.kt", "\\\\src\\\\main\\\\kotlin\\\\ComplexNumber.kt", "\\\\src\\\\main\\\\kotlin\\\\Hamming.kt", "\\\\src\\\\main\\\\kotlin\\\\HelloWorld.kt", "\\\\src\\\\main\\\\kotlin\\\\NumberSpeller.kt", "\\\\src\\\\main\\\\kotlin\\\\Raindrops.kt", "\\\\src\\\\main\\\\kotlin\\\\RotationalCipher.kt", "\\\\src\\\\main\\\\kotlin\\\\ScrabbleScore.kt", "\\\\src\\\\main\\\\kotlin\\\\Series.kt", "\\\\src\\\\main\\\\kotlin\\\\SumOfMultiples.kt", "\\\\src\\\\main\\\\kotlin\\\\Twofer.kt", "\\\\src\\\\main\\\\kotlin\\\\Year.kt", "\\\\strain.ts", "\\\\sublist.ts", "\\\\transpose.js", "\\\\triangle.ts", "\\\\twelve-days.js", "\\\\twelve-days.ts", "\\\\two-fer.js", "\\\\two-fer.ts", "\\\\word-count.ts", "\\\\word_count.exs", "\\\\word_count.rb", "\\csharp\\acronym\\Acronym.cs", "\\csharp\\anagram\\Anagram.cs", "\\csharp\\binary\\Binary.cs", "\\csharp\\clock\\Clock.cs", "\\csharp\\hexadecimal\\Hexadecimal.cs", "\\csharp\\meetup\\Meetup.cs", "\\csharp\\nucleotide-count\\DNA.cs", "\\csharp\\octal\\Octal.cs", "\\csharp\\pig-latin\\PigLatin.cs", "\\csharp\\robot-name\\Robot.cs", "\\csharp\\tournament\\Tournament.cs", "\\csharp\\trinary\\Trinary.cs", "\\csharp\\word-count\\Phrase.cs", "\\fsharp\\accumulate\\Accumulate.fs", "\\fsharp\\acronym\\Acronym.fs", "\\fsharp\\allergies\\Allergies.fs", "\\fsharp\\anagram\\Anagram.fs", "\\fsharp\\atbash-cipher\\Atbash.fs", "\\fsharp\\binary\\Binary.fs", "\\fsharp\\clock\\Clock.fs", "\\fsharp\\crypto-square\\CryptoSquare.fs", "\\fsharp\\etl\\ETL.fs", "\\fsharp\\grade-school\\School.fs", "\\fsharp\\hamming\\Hamming.fs", "\\fsharp\\linked-list\\Deque.fs", "\\fsharp\\luhn\\Luhn.fs", "\\fsharp\\octal\\Octal.fs", "\\fsharp\\pig-latin\\PigLatin.fs", "\\fsharp\\raindrops\\Raindrops.fs", "\\fsharp\\rna-transcription\\RNATranscription.fs", "\\fsharp\\roman-numerals\\RomanNumeral.fs", "\\fsharp\\scrabble-score\\Scrabble.fs", "\\fsharp\\series\\Series.fs", "\\fsharp\\strain\\Strain.fs", "\\fsharp\\trinary\\Trinary.fs", "\\fsharp\\word-count\\WordCount.fs", "\\haskell\\allergies\\Allergies.hs", "\\haskell\\anagram\\Anagram.hs", "\\haskell\\bank-account\\BankAccount.hs", "\\haskell\\beer-song\\Beer.hs", "\\haskell\\binary\\Binary.hs", "\\haskell\\connect\\Connect.hs", "\\haskell\\go-counting\\Counting.hs", "\\haskell\\linked-list\\Deque.hs", "\\haskell\\parallel-letter-frequency\\Frequency.hs", "\\haskell\\pig-latin\\PigLatin.hs", "\\haskell\\prime-factors\\PrimeFactors.hs", "\\haskell\\raindrops\\Raindrops.hs", "\\haskell\\robot-name\\Robot.hs", "\\haskell\\roman-numerals\\Roman.hs", "\\haskell\\saddle-points\\Matrix.hs", "\\haskell\\say\\Say.hs", "\\haskell\\scrabble-score\\Scrabble.hs", "\\haskell\\secret-handshake\\SecretHandshake.hs", "\\haskell\\series\\Series.hs", "\\haskell\\sgf-parsing\\Sgf.hs", "\\haskell\\sieve\\Sieve.hs", "\\haskell\\simple-cipher\\Cipher.hs", "\\haskell\\triangle\\Triangle.hs", "\\haskell\\zipper\\Zipper.hs", "\\java\\anagram\\src\\main\\java\\Anagram.java", "\\java\\bob\\src\\main\\java\\Bob.java", 
    #   "\\java\\etl\\src\\main\\java\\Etl.java", "\\java\\grade-school\\src\\main\\java\\School.java", "\\java\\hamming\\src\\main\\java\\Hamming.java", "\\java\\meetup\\src\\main\\java\\Meetup.java", "\\java\\nucleotide-count\\src\\main\\java\\DNA.java", "\\java\\phone-number\\src\\main\\java\\PhoneNumber.java", "\\java\\robot-name\\src\\main\\java\\Robot.java", "\\java\\word-count\\src\\main\\java\\WordCount.java", "\\scala\\accumulate\\src\\main\\scala\\Accumulate.scala", "\\scala\\house\\src\\main\\scala\\House.scala", "\\scala\\minesweeper\\src\\main\\scala\\Minesweeper.scala", "\\scala\\ocr-numbers\\src\\main\\scala\\Ocr.scala", "\\scala\\octal\\src\\main\\scala\\Octal.scala", "\\scala\\trinary\\src\\main\\scala\\Trinary.scala", "accumulate.exs", "accumulate.js", "accumulate.rb", "acronym.exs", "acronym.js", "acronym.nim", "acronym.rb", "acronym.ts", "all-your-base.js", "all_your_base.nim", "allergies.js", "allergies.nim", "allergies.rb", "alphametics.js", "alphametics.ts", "anagram.js", "anagram.nim", "anagram.rb", "anagram.ts", "armstrong-numbers.ts", "armstrong_numbers.nim", "armstrong_numbers.rb", "atbash-cipher.js", "atbash-cipher.ts", "atbash_cipher.nim", "atbash_cipher.rb", "beer-song.js", "binary-search-tree.js", "binary-search-tree.ts", "binary-search.js", "binary-search.ts", "binary.js", "binary_search.rb", "bob.exs", "bob.js", "bob.nim", "bob.rb", "bob.scala", "bowling.js", "bowling.ts", "bracket-push.js", "bracket_push.rb", "change.js", "circular-buffer.js", "clock.js", "clock.nim", "clock.rb", "clock.ts", "collatz_conjecture.nim", "collatz_conjecture.rb", "complex_numbers.rb", "crypto-square.js", "crypto_square.nim", "custom-set.js", "darts.js", "darts.nim", "darts.rb", "diamond.js", "diamond.nim", "diamond.rb", "diamond.ts", "difference-of-squares.js", "difference_of_squares.exs", "difference_of_squares.nim", "difference_of_squares.rb", "diffie_hellman.nim", "dnd-character.js", "etl.js", "etl.nim", "etl.rb", "flatten-array.js", "flatten_array.rb", "food-chain.js", "forth.js", "gigasecond.js", "gigasecond.nim", "gigasecond.rb", "grade-school.js", "grade_school.nim", "grains.js", "grains.nim", "grains.rb", "grains.ts", "hamming.js", "hamming.nim", "hamming.rb", "hello-world.js", "hello-world.scm", "hello-world.wren", "hello_world.c", "hello_world.cpp", "hello_world.f90", "hello_world.h", "hello_world.nim", "hello_world.pl", "hello_world.rb", "hexadecimal.js", "high-scores.js", "high_scores.nim", "high_scores.rb", "impl.mips", "isbn-verifier.ts", "isbn_verifier.nim", "isogram.js", "isogram.nim", "isogram.rb", "kindergarten-garden.js", "kindergarten-garden.ts", "kindergarten_garden.nim", "kindergarten_garden.rb", "largest-series-product.js", "largest-series-product.ts", "largest_series_product.nim", "lasagna.rb", "leap.js", "leap.nim", "leap.pl", "leap.rb", "lib/lasagna.ex", "lib/rules.ex", "linked-list.js", "linked-list.ts", "list_ops.rb", "luhn.js", "luhn.nim", "luhn.rb", "luhn.ts", "matching_brackets.nim", "matrix.js", "matrix.nim", "matrix.rb", "matrix.ts", "meetup.js", "meetup.nim", "meetup.rb", "microwave.rb", "nth-prime.js", "nth-prime.ts", "nth_prime.nim", "nucleotide_count.exs", "nucleotide_count.nim", "nucleotide_count.rb", "ocr-numbers.js", "octal.js", "palindrome-products.js", "palindrome_products.rb", "pangram.js", "pangram.nim", "pangram.rb", "pangram.ts", "pascals-triangle.js", "pascals-triangle.ts", "pascals_triangle.nim", "pascals_triangle.rb", "perfect-numbers.ts", "perfect_numbers.nim", "perfect_numbers.rb", "phone-number.js", "phone-number.ts", "phone_number.nim", "phone_number.rb", "pig-latin.js", "pig_latin.exs", "pov.hs", "prime-factors.js", "prime-factors.ts", "prime_factors.nim", "prime_factors.rb", "protein_translation.exs", "protein_translation.nim", "protein_translation.rb", "proverb.js", "proverb.nim", "proverb.rb", "proverb.ts", "pythagorean-triplet.js", "pythagorean-triplet.ts", "pythagorean_triplet.rb", "queen-attack.js", "queen_attack.nim", "queen_attack.pl", "queen_attack.rb", "raindrops.js", "raindrops.nim", "raindrops.rb", "rational-numbers.js", "rational-numbers.ts", "react.js", "react.nim", "resistor-color-duo.js", "resistor-color-duo.ts", "resistor-color.js", "resistor-color.ts", "resistor_color.nim", "resistor_color.rb", "resistor_color_duo.nim", "resistor_color_duo.rb", "resistor_color_trio.nim", "reverse_string.nim", "rna-transcription.js", "rna_transcription.nim", "rna_transcription.rb", "robot-name.js", "robot-simulator.js", "robot-simulator.ts", "robot_name.nim", "robot_name.rb", "robot_simulator.rb", "roman-numerals.js", "roman-numerals.ts", "roman_numerals.nim", "roman_numerals.rb", "rotational_cipher.nim", "run-length-encoding.ts", "run_length_encoding.nim", "saddle-points.js", "saddle_points.nim", "saddle_points.rb", "say.js", "say.nim", "say.ts", "scale_generator.nim", "scale_generator.rb", "scrabble-score.js", "scrabble-score.ts", "scrabble_score.nim", "scrabble_score.rb", "secret-handshake.js", "secret-handshake.ts", "secret_handshake.nim", "secret_handshake.rb", "series.js", "series.nim", "series.rb", "series.ts", "sieve.js", "sieve.nim", "sieve.rb", "sieve.ts", "simple-cipher.js", "space-age.js", "space-age.ts", "space_age.exs", "space_age.nim", "space_age.rb", "spiral-matrix.cabal", "spiral-matrix.ts", "spiral_matrix.nim", "src/Acronym.hs", "src/Alphametics.hs", "src/ArmstrongNumbers.hs", "src/Base.hs", "src/BinarySearch.hs", "src/Bowling.hs", "src/Brackets.hs", "src/Change.hs", "src/CollatzConjecture.hs", "src/ComplexNumbers.hs", "src/DND.hs", "src/Diamond.hs", "src/Dominoes.hs", "src/HelloWorld.hs", "src/HelloWorld.purs", "src/IsbnVerifier.hs", "src/Isogram.hs", "src/Pangram.hs", "src/PerfectNumbers.hs", "src/Poker.hs", "src/ProteinTranslation.hs", "src/Proverb.hs", "src/RailFenceCipher.hs", "src/ResistorColors.hs", "src/RotationalCipher.hs", "src/RunLength.hs", "src/Spiral.hs", "src/Transpose.hs", "src/TwelveDays.hs", "src/ZebraPuzzle.hs", "src/armstrong_numbers.clj", "src/hello-world.lfe", "src/hello_world.cr", "src/hello_world.erl", "src/leap.clj", "src/leap.cr", "src/lib.rs", "src/lucians_luscious_lasagna.clj", "src/main/java/Accumulate.java", "src/main/java/Acronym.java", "src/main/java/Allergies.java", "src/main/java/Atbash.java", "src/main/java/BST.java", "src/main/java/BaseConverter.java", "src/main/java/BeerSong.java", "src/main/java/Binary.java", "src/main/java/BinarySearch.java", "src/main/java/BracketChecker.java", "src/main/java/ChangeCalculator.java", "src/main/java/Cipher.java", "src/main/java/Clock.java", "src/main/java/Crypto.java", "src/main/java/CustomSet.java", "src/main/java/Deque.java", "src/main/java/DiamondPrinter.java", "src/main/java/Difference.java", "src/main/java/Flattener.java", "src/main/java/Gigasecond.java", "src/main/java/HandshakeCalculator.java", "src/main/java/HelloWorld.java", "src/main/java/Hexadecimal.java", "src/main/java/LargestSeriesProductCalculator.java", "src/main/java/ListOps.java", "src/main/java/Luhn.java", "src/main/java/Matrix.java", "src/main/java/MinesweeperBoard.java", "src/main/java/NaturalNumber.java", "src/main/java/Octal.java", "src/main/java/OpticalCharacterReader.java", "src/main/java/Palindromes.java", "src/main/java/Pangrams.java", "src/main/java/PascalsTriangle.java", "src/main/java/PhoneNumber.java", "src/main/java/PigLatin.java", "src/main/java/Prime.java", "src/main/java/PrimeFactors.java", "src/main/java/PythagoreanTriplet.java", "src/main/java/PythagoreanTripletBuilder.java", "src/main/java/QueenAttackCalculator.java", "src/main/java/Raindrops.java", "src/main/java/RectangleCounter.java", "src/main/java/RelationshipComputer.java", "src/main/java/RnaTranscription.java", "src/main/java/Robot.java", "src/main/java/RomanNumeral.java", "src/main/java/Scrabble.java", "src/main/java/Series.java", "src/main/java/Sieve.java", "src/main/java/SimpleLinkedList.java", "src/main/java/SpaceAge.java", "src/main/java/Strain.java", "src/main/java/SumOfMultiples.java", "src/main/java/Triangle.java", "src/main/java/Trinary.java", "src/main/java/TwelveDays.java", "src/main/java/Twofer.java", "src/main/java/WordProblemSolver.java", "src/main/kotlin/Accumulate.kt", "src/main/kotlin/Acronym.kt", "src/main/kotlin/Allergies.kt", "src/main/kotlin/Anagram.kt", "src/main/kotlin/Atbash.kt", "src/main/kotlin/BankAccount.kt", "src/main/kotlin/BaseConverter.kt", "src/main/kotlin/BeerSong.kt", "src/main/kotlin/Binary.kt", "src/main/kotlin/BinarySearch.kt", "src/main/kotlin/Board.kt", "src/main/kotlin/Bob.kt", "src/main/kotlin/BracketPush.kt", "src/main/kotlin/Change.kt", "src/main/kotlin/Cipher.kt", "src/main/kotlin/CollatzCalculator.kt", "src/main/kotlin/DNA.kt", "src/main/kotlin/Deque.kt", "src/main/kotlin/DiamondPrinter.kt", "src/main/kotlin/ETL.kt", "src/main/kotlin/Flattener.kt", "src/main/kotlin/ForthEvaluator.kt", "src/main/kotlin/Gigasecond.kt", "src/main/kotlin/Hamming.kt", "src/main/kotlin/HandshakeCalculator.kt", "src/main/kotlin/HelloWorld.kt", "src/main/kotlin/Hexadecimal.kt", "src/main/kotlin/IsbnVerifier.kt", "src/main/kotlin/Isogram.kt", "src/main/kotlin/ListExtensions.kt", "src/main/kotlin/Luhn.kt", "src/main/kotlin/Matrix.kt", "src/main/kotlin/Meetup.kt", "src/main/kotlin/MinesweeperBoard.kt", "src/main/kotlin/NaturalNumber.kt", "src/main/kotlin/Pangrams.kt", "src/main/kotlin/PascalsTriangle.kt", "src/main/kotlin/PhoneNumber.kt", "src/main/kotlin/PigLatin.kt", "src/main/kotlin/Prime.kt", "src/main/kotlin/PrimeFactorCalculator.kt", "src/main/kotlin/RailFenceCipher.kt", "src/main/kotlin/Raindrops.kt", "src/main/kotlin/React.kt", "src/main/kotlin/ReverseString.kt", "src/main/kotlin/RnaTranscription.kt", "src/main/kotlin/Robot.kt", "src/main/kotlin/RomanNumeral.kt", "src/main/kotlin/School.kt", "src/main/kotlin/Scrabble.kt", "src/main/kotlin/Series.kt", "src/main/kotlin/Sieve.kt", "src/main/kotlin/SpaceAge.kt", "src/main/kotlin/SpiralMatrix.kt", "src/main/kotlin/Squares.kt", "src/main/kotlin/Strain.kt", "src/main/kotlin/Sublist.kt", "src/main/kotlin/Triangle.kt", 
    #   "src/main/kotlin/WordCount.kt", "src/main/kotlin/Year.kt", "src/main/scala/Acronym.scala", "src/main/scala/AllYourBase.scala", "src/main/scala/Alphametics.scala", "src/main/scala/ArmstrongNumbers.scala", "src/main/scala/BeerSong.scala", "src/main/scala/BinarySearch.scala", "src/main/scala/BookStore.scala", "src/main/scala/Bowling.scala", "src/main/scala/Brackets.scala", "src/main/scala/Change.scala", "src/main/scala/Cipher.scala", "src/main/scala/CollatzConjecture.scala", "src/main/scala/ComplexNumber.scala", "src/main/scala/Connect.scala", "src/main/scala/CustomSet.scala", "src/main/scala/Darts.scala", "src/main/scala/Deque.scala", "src/main/scala/Diamond.scala", "src/main/scala/Dominoes.scala", "src/main/scala/FlattenArray.scala", "src/main/scala/FoodChain.scala", "src/main/scala/ForthEvaluator.scala", "src/main/scala/Frequency.scala", "src/main/scala/HelloWorld.scala", "src/main/scala/HighScores.scala", "src/main/scala/Isogram.scala", "src/main/scala/LensPerson.scala", "src/main/scala/Matrix.scala", "src/main/scala/PalindromeProducts.scala", "src/main/scala/Pangrams.scala", "src/main/scala/PascalsTriangle.scala", "src/main/scala/PerfectNumbers.scala", "src/main/scala/PigLatin.scala", "src/main/scala/ProteinTranslation.scala", "src/main/scala/PythagoreanTriplet.scala", "src/main/scala/RailFenceCipher.scala", "src/main/scala/RotationalCipher.scala", "src/main/scala/RunLengthEncoding.scala", "src/main/scala/Say.scala", "src/main/scala/SecretHandshake.scala", "src/main/scala/Series.scala", "src/main/scala/Sgf.scala", "src/main/scala/Sieve.scala", "src/main/scala/SimpleLinkedList.scala", "src/main/scala/SpiralMatrix.scala", "src/main/scala/Strain.scala", "src/main/scala/SumOfMultiples.scala", "src/main/scala/Twofer.scala", "src/main/scala/VariableLengthQuantity.scala", "src/main/scala/WordProblem.scala", "src/main/scala/ZebraPuzzle.scala", "src/main/scala/Zipper.scala", "src/reverse_string.clj", "src/test/scala/Prime.scala", "src/two_fer.clj", "strain.exs", "strain.js", "strain.rb", "sublist.js", "sublist.nim", "sum-of-multiples.js", "sum-of-multiples.ts", "sum_of_multiples.nim", "sum_of_multiples.rb", "tournament.rb", "transpose.rb", "transpose.ts", "triangle.js", "triangle.nim", "triangle.pl", "triangle.rb", "trinary.js", "twelve_days.nim", "twelve_days.rb", "two-bucket.js", "two-bucket.ts", "two_fer.exs", "two_fer.go", "two_fer.nim", "two_fer.rb", "variable-length-quantity.js", "variable-length-quantity.ts", "word-count.js", "word-search.js", "word-search.ts", "word_count.exs", "word_count.nim", "word_count.rb", "wordy.js", "wordy.ts", "yacht.nim", "zipper.js",
    # ]

    files = [
      "/haskell/atbash-cipher/Atbash.hs",
      "\\java\\etl\\src\\main\\java\\Etl.java",
      "\\java\\grade-school\\src\\main\\java\\School.java",
      "src/main/kotlin/WordCount.kt", 
    ]
    
    files.each do |file|
      submission.files.create!(filename: file, content: "dummy content", digest: SecureRandom.uuid)
    end

    # Create regular expression to match one of the track slugs
    track_slugs = Track.pluck(:slug).map {|slug| Regexp.escape(slug)}
    track_slug_regex_match = "(#{track_slugs.join('|')})"

    files_to_upsert = []

    Submission::File.find_each do |file|
      sanitized_file = file.filename
        .gsub(/\\+/, '/') # Replace one or more consecutive backslashes with one slash
        .gsub(/.*?\/#{track_slug_regex_match}\/[^\/]+\/(.+)/, '\2') # Strip off everything before and including the <track>/<exercise> part of the path         
        .gsub(/^\//, '') # Remove leading slash
      
      next if file.filename == sanitized_file

      attrs = file.attributes
      attrs[:filename] = sanitized_file
      files_to_upsert << attrs
    end

    Submission::File.upsert_all(files_to_upsert)
  end
end