defmodule Mp3Info do

  @file_name "Divider.mp3"

  def id3_v2_basic_info(input_file \\ @file_name) do
    {:ok, mp3_file} = File.read(input_file)
    <<  tag_id   :: binary-size(3),
        major_v  :: unsigned-integer-size(8),
        revision :: unsigned-integer-size(8),
        _        :: bitstring >> = mp3_file
    IO.puts """
    [ID3v2 Info]
    Tag:            #{tag_id}
    Major Version:  #{major_v}
    Revision:       #{revision}
    """
  end

  def id3_v1_info(input_file \\ @file_name) do
    {:ok, mp3_file} = File.read(input_file)
    mp3_size_without_id3 = (byte_size(mp3_file) - 128)
    << _ :: binary-size(mp3_size_without_id3), id3_v1_tag_data :: binary >> = mp3_file

    << tag      :: binary-size(3),
       title    :: binary-size(30),
       artist   :: binary-size(30),
       album    :: binary-size(30),
       year     :: binary-size(4),
       comments :: binary-size(30),
       _        :: binary >> = id3_v1_tag_data

    IO.puts """
    [ID3v1 Info]
    Tag:            #{tag}
    Title:          #{title}
    Artist:         #{artist}
    Album:          #{album}
    Year:           #{year}
    Comments:       #{comments}
    """
  end

  def write_info(input_file \\ @file_name, output_file \\ "new.mp3") do
    {:ok, mp3_file} = File.read(input_file)
    tag      = "TAG"
    author   = pad("Chris Zabriskie", 30)
    title    = pad("Divider", 30)
    album    = pad("Divider", 30)
    year     = "2011"
    comments = pad("Copyright: Creative Commons", 30)

    tag_to_write = pad((tag <> author <> title <> album <> year <> comments), 128)

    mp3_size_without_id3 = (byte_size(mp3_file) - 128)
    << other_data :: binary-size(mp3_size_without_id3), _ :: binary >> = mp3_file

    File.write(output_file, (other_data <> tag_to_write))
  end


  defp pad(string, desired_size) do
    String.ljust(string,desired_size)
  end

end
