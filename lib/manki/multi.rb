class Manki::Multi

  def initialize(:mankis)
    @mankis = mankis
  end

  def method_missing
    responses = []

    for manki in @mankis
      reponses << manki.send(:method)
    end

    return responses
  end


end
