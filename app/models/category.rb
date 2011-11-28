class Category < ActiveRecord::Base
  attr_accessible :name, :code, :shape, :color
  has_many :subcategories
  validates_uniqueness_of :code
  default_scope :order => 'code ASC'  
  validates_presence_of :name, :code
  validates_uniqueness_of :color, :scope => :shape
  validates_uniqueness_of :shape, :scope => :color

  LABEL_COLORS = %w{
    d9d9d9
    00afea
    f60087
    fff152
    ef9d25
    85c657
  } # Old orange was fa6232
  
  LABEL_SHAPES = %w{
    square
    x
    plus
    triangle
    circle
    diamond
  }
  
  SHAPE_SYMBOLS = {
    'square'   => '&#9724;',
    'x'        => '&#10006;',
    'plus'     => '&#10010;',
    'triangle' => '&#9650;',
    'circle'   => '&#9899;',
    'diamond'  => '&#9830;'
  }
  
  def name_with_code
    "#{code} - #{name}"
  end
  
  def to_s
    name_with_code
  end
  
end
