class Url < ApplicationRecord
  include Redis::Objects
  validates :original_url, presence: true, on: :create
  before_create :generate_short_url

  def generate_short_url
    chars = ['0'..'9','A'..'Z','a'..'z'].map{|range| range.to_a}.flatten
    self.short_url = 6.times.map{chars.sample}.join
    self.short_url = 6.times.map{chars.sample}.join until Url.find_by_short_url(self.short_url).nil?
  end

  def find_duplicate
    Url.find_by_sanitized_url(self.sanitized_url)
  end

  def new_url?
    find_duplicate.nil?
  end

  def sanitize
    self.original_url.strip!
    self.sanitized_url = self.original_url.downcase.gsub(/(https?:\/\/)|(www\.)/, "")
    self.sanitized_url.slice!(-1) if self.sanitized_url[-1] == "/"
    self.sanitized_url = "http://#{self.sanitized_url}"
  end

  def views
    #self.increment!(:visit_count)
    self.visit_count += 1
    save!
  end
end
