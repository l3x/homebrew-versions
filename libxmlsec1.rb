require "formula"

class Libxmlsec1 < Formula
  homepage "https://www.aleksey.com/xmlsec/"
  url "https://www.aleksey.com/xmlsec/download/xmlsec1-1.2.20.tar.gz"
  sha1 "40117ab0f788e43deef6eaf028c88f6abc3a30d0"

  bottle do
    sha1 "7cfecf66f3608695321bc195b35957f2dddeb354" => :yosemite
    sha1 "ff35feb04a9f18af8cf96aacc340e25e60adb542" => :mavericks
    sha1 "9b4df5db57f11d86d63fc7dcaa51939d9b874c23" => :mountain_lion
  end

  depends_on "pkg-config" => :build
#  depends_on "libxml2" if MacOS.version <= :lion
  # Yes, it wants both ssl/tls variations.
#  depends_on "openssl" => :recommended
#  depends_on "gnutls" => :recommended
#  depends_on "libgcrypt" if build.with? "gnutls"

  # Add HOMEBREW_PREFIX/lib to dl load path
  patch :DATA

  def install
    args = ["--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--with-libxml=#{Formula.factory("libxml2").opt_prefix}",
            "--disable-crypto-dl",
            "--disable-apps-crypto-dl",
            "--with-openssl=/usr/local/Cellar/openssl/1.0.1j/"
    ]

    args << "--with-openssl=#{Formula["openssl"].opt_prefix}" if build.with? "openssl"
    args << "--with-libxml=#{Formula["libxml2"].opt_prefix}" if build.with? "libxml2"

    system "./configure", *args
    system "make", "install"
  end
end
