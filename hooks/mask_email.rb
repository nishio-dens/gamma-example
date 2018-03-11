class MaskEmail
  def execute(apply, column, value)
    result = value.split("@")[0]
    result = "#{result}@example.com"

    unless apply
      puts "[DRYRUN] #{column} #{value}"
    end

    result
  end
end
