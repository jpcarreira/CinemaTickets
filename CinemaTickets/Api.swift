import Foundation


/**
 By defining the ApiType as a protocol we can implement different concretizations of this protocol,
 one being the "real api" (which would connect to the production API) and the one can be a MockAPI
 (where we can fake network requests)
 */
protocol ApiType {
    
    func fetchAllMovies(completion: @escaping ([MovieApiData]?) -> Void)
}


// in a real-word app we'd have to implement all methods on this class to actually fetch data
// from the API, using an HTTP client like Alamofire to get data from a server
final class Api: ApiType {
    
    func fetchAllMovies(completion: @escaping ([MovieApiData]?) -> Void) {
        fatalError("Requires implementation")
    }
}


final class MockApi: ApiType {
    
    // network delay to fake
    static let delay = 1
    
    // some fake movie data
    static let movies = [
        MovieApiData(
            title: "Star Wars Ep I: The Phantom Menace",
            synopsis: nil,
            actors: ["Liam Neeson", "Ewan McGregor", "Natalie Portman"]),
        MovieApiData(
            title: "Star Wars Ep II: Attack Of The Clones",
            synopsis: nil,
            actors: ["Ewan McGregor", "Hayden Christensen", "Natalie Portman"]),
        MovieApiData(
            title: "Star Wars Ep III: Revenge Of The Sith",
            synopsis: nil,
            actors: ["Ewan McGregor", "Hayden Christensen", "Natalie Portman"]),
        MovieApiData(
            title: "Star Wars Ep IV: A New Hope",
            synopsis: "The galaxy is in the midst of a civil war. Rebel spies have stolen plans to the Galactic Empire's Death Star, a colossal space station capable of destroying an entire planet. Princess Leia, one of the Rebellion's leaders, has obtained the plans, but her starship is captured by an Imperial Star Destroyer under the command of the ruthless Darth Vader. Before she is captured, Leia hides the plans in the memory of astromech droid R2-D2, who, along with protocol droid C-3PO, flees in an escape pod to the desert planet below the starships, Tatooine.",
            actors: ["Mark Hamill", "Harrison Ford", "Carrie Fisher"]),
        MovieApiData(
            title: "Star Wars Ep V: The Empire Strikes Back",
            synopsis: "Three years after the destruction of the Death Star, the Rebel Alliance, led by Princess Leia, has set up a new base on the ice planet of Hoth. The Imperial fleet, led by Darth Vader, continues to hunt for the new Rebel base by dispatching probe droids across the galaxy. Luke Skywalker is captured by a wampa while investigating one such probe, but manages to escape from the wampa's lair with his lightsaber. Before Luke succumbs to hypothermic sleep, the Force ghost of his late mentor, Obi-Wan Kenobi, instructs him to go to Dagobah to train under Jedi Master Yoda. Han Solo locates Luke and cuts open the tauntaun he rode there on to keep his friend warm; they wait there until being rescued by a search party the next morning.",
            actors: ["Mark Hamill", "Harrison Ford", "Carrie Fisher"]),
        MovieApiData(
            title: "Star Wars Ep VI: The Return of The Jedi",
            synopsis: "In an attempt to rescue Han Solo from crimelord Jabba the Hutt, C-3PO and R2-D2 are sent to Jabba's palace on Tatooine in a trade bargain made by Luke Skywalker. Disguised as a bounty hunter, Princess Leia infiltrates the palace under the pretense of collecting the bounty on Chewbacca and unfreezes Han, but is caught and enslaved. Luke arrives soon afterward, but after a tense standoff, is sent through a trapdoor to do battle with Jabba's rancor. Jabba sentences Luke and Han to death by being fed to the Sarlacc. Having hidden his lightsaber inside R2-D2, Luke frees himself and battles Jabba's guards while Leia uses her chains to strangle Jabba. As the others rendezvous with the Rebel Alliance, Luke returns to Dagobah, where he finds that Yoda is dying. Yoda confirms that Darth Vader, once known as Anakin Skywalker, is Luke's father. The spirit of Obi-Wan Kenobi reveals that Leia is Luke's twin sister. The Jedi Masters tell Luke that he must face Vader again to defeat the Empire and become a Jedi Knight.",
            actors: ["Mark Hamill", "Harrison Ford", "Carrie Fisher"]),
        MovieApiData(
            title: "Star Wars Ep VII: The Force Awakens",
            synopsis: "Thirty years after the Galactic Civil War, the First Order has risen from the fallen Galactic Empire and seeks to eliminate the New Republic. The Resistance, backed by the Republic and led by General Leia Organa, opposes them while Leia searches for her brother, Luke Skywalker.",
            actors: ["Mark Hamill", "Harrison Ford", "Carrie Fisher", "Adam Driver", "Daisy Ridley"]),
        MovieApiData(
            title: "Star Wars Ep VIII: The Last Jedi",
            synopsis: nil,
            actors: ["Mark Hamill", "Harrison Ford", "Carrie Fisher", "Adam Driver", "Daisy Ridley"])
    ]
    
    func fetchAllMovies(completion: @escaping ([MovieApiData]?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(MockApi.delay)) {
            completion(MockApi.movies)
        }
    }
}
