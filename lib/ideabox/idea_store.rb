class IdeaStore

  def self.save(idea)
    @all ||= []
    idea.id = next_id
    @all << idea
    idea.id
  end

  def self.find(id)
    @all.find do |idea|
      idea.id == id
    end
  end

  def self.count
    @all.length
  end

  def self.next_id
    count + 1
  end

end
