class ArrowCpp < Formula
  desc "Apache Arrow"
  homepage "https://arrow.apache.org/"
  url "https://github.com/apache/arrow/archive/apache-arrow-0.4.0.tar.gz"
  sha256 "0ce9f47e42735d8d48dd83f9ff6a1612c5f2a8e846f3ae23595697e3519dd9b8"

  head "https://github.com/apache/arrow.git"

  depends_on "boost" => :build
  depends_on "cmake" => :build

  def install
    env = ENV["PATH"]
    new_env = Array.new
    env.split(":").each do |value|
      if !value.include? "shims/super"
        new_env.push value
      end
    end
    new_env.push "/usr/local/bin"
    ENV.store 'PATH', new_env.join(":")
    chdir "cpp"
    build_type = "Release"
    mkdir "#{build_type.downcase}"
    chdir "#{build_type.downcase}"
    system "cmake", "..", "-D", "CMAKE_BUILD_TYPE=#{build_type}", "-D", "CMAKE_INSTALL_PREFIX:PATH=#{prefix}"
    system "make unittest"
    system "make", "install"
  end
end
