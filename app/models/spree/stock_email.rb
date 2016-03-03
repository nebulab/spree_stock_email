class Spree::StockEmail < ActiveRecord::Base

  belongs_to :variant

  validates :variant, presence: true
  validates :email, presence: true, email: true

  validate :unique_variant_email

  scope :not_sent, -> { where(sent_at: nil) }
  scope :sent, -> { where.not(sent_at: nil) }

  def self.email_exists?(variant, email)
    exists?(sent_at: nil, variant_id: variant.id, email: email)
  end

  def self.notify(variant)
    where(sent_at: nil, variant_id: [variant.id, variant.product.master.id]).each { |e| e.notify }
  end

  def email_exists?
    self.class.email_exists?(variant, email)
  end

  def notify
    Spree::StockEmailsMailer.stock_email(self).deliver_later rescue nil
    mark_as_sent
  end

  def self.awaiting_users
    not_sent.size
  end

  def self.notified_users
    sent.size
  end

  def self.summary
    Spree::StockEmail.all.
    group_by { |e| e.variant_id }.
    sort_by { |variant| variant.second.select { |stock_email| stock_email.sent_at.nil? }.size }.
    reverse
  end

  def self.variant_options_text_short(variant)
    variant.option_values.map { |ov| "#{ov.presentation}" }.to_sentence({:words_connector => ", ", :two_words_connector => ", "})
  end

  private

  def unique_variant_email
    errors.add :user, "already registered for notifications on this product" if email_exists?
  end

  def mark_as_sent
    touch(:sent_at)
  end

end
