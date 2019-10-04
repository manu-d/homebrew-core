class Ntmoswiftlint < Formula
  desc "Tool to enforce Swift style and conventions"
  homepage "https://github.com/manu-d/SwiftLint"
  head "https://github.com/manu-d/SwiftLint.git", :branch => "master", :revision => "f5d1a028b86decaef34b977dc370b29ea35441da"

  depends_on :xcode => ["10.0", :build]
  depends_on :xcode => "8.0"

  def install
    system "make", "prefix_install", "PREFIX=#{prefix}", "TEMPORARY_FOLDER=#{buildpath}/NtmoSwiftLint.dst"
  end

  test do
    (testpath/"Test.swift").write "import Foundation"
    assert_match "Test.swift:1:1: warning: Trailing Newline Violation: Files should have a single trailing newline. (trailing_newline)",
                 shell_output("SWIFTLINT_SWIFT_VERSION=3 SWIFTLINT_DISABLE_SOURCEKIT=1 #{bin}/ntmoswiftlint lint --no-cache").chomp
    assert_match version.to_s,
                 shell_output("#{bin}/ntmoswiftlint version").chomp
  end
end
