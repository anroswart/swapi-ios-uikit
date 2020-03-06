@testable import mvvm_test_1
import RealmSwift

class FilmMocks {
    static var aNewHope: Film {
        let mockOpeningCrawl = "It is a period of civil war.\r\nRebel spaceships, striking\r\nfrom a hidden base, have won\r\ntheir first victory against\r\nthe evil Galactic Empire.\r\n\r\nDuring the battle, Rebel\r\nspies managed to steal secret\r\nplans to the Empire's\r\nultimate weapon, the DEATH\r\nSTAR, an armored space\r\nstation with enough power\r\nto destroy an entire planet.\r\n\r\nPursued by the Empire's\r\nsinister agents, Princess\r\nLeia races home aboard her\r\nstarship, custodian of the\r\nstolen plans that can save her\r\npeople and restore\r\nfreedom to the galaxy...."
        let mockCharacterURLs = ["https://swapi.co/api/people/1/",
                                 "https://swapi.co/api/people/2/",
                                 "https://swapi.co/api/people/3/",
                                 "https://swapi.co/api/people/4/",
                                 "https://swapi.co/api/people/5/",
                                 "https://swapi.co/api/people/6/",
                                 "https://swapi.co/api/people/7/",
                                 "https://swapi.co/api/people/8/",
                                 "https://swapi.co/api/people/9/",
                                 "https://swapi.co/api/people/10/"]
        let mockCharacterList = ["Luke Skywalker",
                                 "C-3PO",
                                 "R2-D2",
                                 "Darth Vader",
                                 "Leia Organa",
                                 "Owen Lars",
                                 "Beru Whitesun lars",
                                 "R5-D4",
                                 "Biggs Darklighter",
                                 "Obi-Wan Kenobi"]
        let mockFilm = Film(title: "A New Hope", releaseDate: "1977-05-25", director: "George Lucas", producer: "Gary Kurtz, Rick McCallum", openingCrawl: mockOpeningCrawl, characterURLs: mockCharacterURLs)
        mockFilm.characterList.append(objectsIn: mockCharacterList)
        mockFilm.rating = RealmOptional<Double>(8.2)
        mockFilm.posterData = UIImage(named: "background", in: Bundle.main, compatibleWith: nil)?.pngData()
        return mockFilm
    }
    
    static var theEmpireStrikesBack: Film {
        let mockOpeningCrawl = "It is a dark time for the\r\nRebellion. Although the Death\r\nStar has been destroyed,\r\nImperial troops have driven the\r\nRebel forces from their hidden\r\nbase and pursued them across\r\nthe galaxy.\r\n\r\nEvading the dreaded Imperial\r\nStarfleet, a group of freedom\r\nfighters led by Luke Skywalker\r\nhas established a new secret\r\nbase on the remote ice world\r\nof Hoth.\r\n\r\nThe evil lord Darth Vader,\r\nobsessed with finding young\r\nSkywalker, has dispatched\r\nthousands of remote probes into\r\nthe far reaches of space...."
        let mockCharacterURLs = ["https://swapi.co/api/people/1/",
                                 "https://swapi.co/api/people/2/",
                                 "https://swapi.co/api/people/3/",
                                 "https://swapi.co/api/people/4/",
                                 "https://swapi.co/api/people/5/",
                                 "https://swapi.co/api/people/10/"]
        let mockCharacterList = ["Luke Skywalker",
                                 "C-3PO",
                                 "R2-D2",
                                 "Darth Vader",
                                 "Leia Organa",
                                 "Obi-Wan Kenobi"]
        let mockFilm = Film(title: "The Empire Strikes Back", releaseDate: "1980-05-17", director: "Irvin Kershner", producer: "Gary Kurtz, Rick McCallum", openingCrawl: mockOpeningCrawl, characterURLs: mockCharacterURLs)
        mockFilm.characterList.append(objectsIn: mockCharacterList)
        mockFilm.rating = RealmOptional<Double>(8.4)
        mockFilm.posterData = UIImage(named: "background", in: Bundle.main, compatibleWith: nil)?.pngData()
        return mockFilm
    }
    
    static var theForceAwakens: Film {
        let mockOpeningCrawl = "Luke Skywalker has vanished.\r\nIn his absence, the sinister\r\nFIRST ORDER has risen from\r\nthe ashes of the Empire\r\nand will not rest until\r\nSkywalker, the last Jedi,\r\nhas been destroyed.\r\n \r\nWith the support of the\r\nREPUBLIC, General Leia Organa\r\nleads a brave RESISTANCE.\r\nShe is desperate to find her\r\nbrother Luke and gain his\r\nhelp in restoring peace and\r\njustice to the galaxy.\r\n \r\nLeia has sent her most daring\r\npilot on a secret mission\r\nto Jakku, where an old ally\r\nhas discovered a clue to\r\nLuke\'s whereabouts...."
        let mockCharacterURLs = ["https://swapi.co/api/people/1/",
                                 "https://swapi.co/api/people/3/",
                                 "https://swapi.co/api/people/5/",]
        let mockCharacterList = ["Luke Skywalker",
                                 "R2-D2",
                                 "Leia Organa"]
        let mockFilm = Film(title: "The Force Awakens", releaseDate: "2015-12-11", director: "J. J. Abrams", producer: "Kathleen Kennedy, J. J. Abrams, Bryan Burk", openingCrawl: mockOpeningCrawl, characterURLs: mockCharacterURLs)
        mockFilm.characterList.append(objectsIn: mockCharacterList)
        mockFilm.rating = RealmOptional<Double>(7.4)
        mockFilm.posterData = UIImage(named: "background", in: Bundle.main, compatibleWith: nil)?.pngData()
        return mockFilm
    }
}
