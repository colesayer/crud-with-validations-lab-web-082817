class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: {scope: :release_year}
  validates :released, exclusion: { in: [nil] }
  validates :artist_name, presence: true
  validates :release_year, presence: true, if: :song_released?
  validate :released_before_now



  def song_released?
    self.released == true
  end

  def released_before_now
    if self.release_year
      if Time.now.year >= self.release_year
        return true
      else
        self.errors[:release_year] << "we're all fucked"
      end
    end
  end

end
