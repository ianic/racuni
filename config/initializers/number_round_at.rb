#kod ukraden iz facets gema
#'facets/core/float/round_at'
class Float

  # Float#round_off is simple an alias for Float#round.

  alias_method :round_off, :round

end

class Float

  # Rounds to the given decimal position.
  #
  #   4.555.round_at(0)  #=> 5.0
  #   4.555.round_at(1)  #=> 4.6
  #   4.555.round_at(2)  #=> 4.56
  #   4.555.round_at(3)  #=> 4.555
  #
  def round_at( d ) #d=0
    (self * (10.0 ** d)).round_off.to_f / (10.0 ** d)
  end
end

class Numeric
  # To properly support Float's rounding methods,
  # Numeric must also be augmented.
  def round_at(*args)
    self.to_f.round_at(*args)
  end
end

class Integer
  # To properly support Float's rounding methods,
  # Integer must also be augmented.
  def round_at(*args)
    self.to_f.round_at(*args)
  end
end
