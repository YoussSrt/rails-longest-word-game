class GamesController < ApplicationController
  def new
    # Générer 10 lettres aléatoires
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split(',') # Je récupère les lettres de la grille sous forme d'array

    # Vérifie si le mot peut être construit à partir des lettres
    contained = @word.chars.all? { |letter| @letters.include?(letter) }

    # Vérifie si le mot existe dans le dictionnaire
    found = JSON.parse(URI.open("https://dictionary.lewagon.com/#{@word}").read)["found"]

    # Gère les trois scénarios
    if !contained
      @message = "Sorry, but #{@word} can't be built out of #{@letters.join(', ')}"
      @score = 0 # Pas de score pour ce mot
      @status_class = "text-danger" # Classe pour afficher en rouge
    elsif !found
      @message = "Sorry, but #{@word} does not seem to be a valid English word"
      @score = 0 # Pas de score pour ce mot
      @status_class = "text-danger" # Classe pour afficher en rouge
    else
      @message = "Congratulations! #{@word} is a valid English word"
      @score = @word.length ** 2 # Exemple: utiliser le carré de la longueur du mot
      @status_class = "text-success" # Classe pour afficher en vert
    end

    # Si la clé 'total_score' n'existe pas dans la session, on l'initialise à 0
    session[:total_score] ||= 0
    
    # Ajoute le score de cette partie au score total
    session[:total_score] += @score

    # Affiche le score total dans la vue
    @total_score = session[:total_score]
  end
end
