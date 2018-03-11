class CopyImage
  def execute(apply, record)
    if apply
      # ここに画像コピーする処理を記載する
      puts "Copy Image. id: #{record["image_path"]}"
    else
      puts "[DRYRUN] Copy Image: #{record}"
    end

    record
  end
end
