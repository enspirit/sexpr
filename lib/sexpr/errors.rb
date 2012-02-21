module Sexpr

  class Error < StandardError
  end

  class UnrecognizedParserError < Error
  end

  class InvalidParseSourceError < Error
  end

  class NoParserError < Error
  end

  class UnexpectedSexprError < Error
  end

end