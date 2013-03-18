# encoding: UTF-8

# Converts a string to UTF-8. If the string is already valid UTF-8, it just
# marks it as such. If the string isn't valid UTF-8, we assume that it's
# ISO-8859-1 or Windows-1252 and convert it. If it's not valid in that encoding
# either, we just strip all non-UTF-8 characters and call it a day.
#
# Destructive!
def force_utf8!(string)
  string.force_encoding "UTF-8"
  return string if string.valid_encoding?

  begin
    string.force_encoding "Windows-1252" # common superset of 8859-1
    string.encode! "UTF-8"
  rescue Encoding::InvalidByteSequenceError,
          Encoding::UndefinedConversionError
    string.force_encoding "UTF-8"
    string.encode! "UTF-16",
      invalid: :replace, undef: :replace, replace: ""
    string.encode! "UTF-8"
  end
end

