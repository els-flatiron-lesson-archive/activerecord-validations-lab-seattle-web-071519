class Post < ActiveRecord::Base
    validates :title, presence: true
    validates :summary, length: {maximum: 250}
    validates :content, length: {minimum: 250}
    validates :category, inclusion: { in: %w(Fiction Nonfiction)}
    validate :is_clickbait?

    CLICKBAIT_PATTERN = [
        /Won't Believe/i,
        /Secret/i,
        /Top [0-9]*/i,
        /Guess/i
    ]


    def is_clickbait?
        if CLICKBAIT_PATTERN.none? { |phrase| phrase.match title}
            errors[:title] << 'Not Clickbaity Enough!'
        end
    end
end
