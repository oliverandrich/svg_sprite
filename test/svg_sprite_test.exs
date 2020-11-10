defmodule SvgSpriteTest do
  use ExUnit.Case
  alias SvgSprite
  import Phoenix.HTML

  describe "test icon/2" do
    test "with binary arguments, returns safe string" do
      assert safe_to_string(SvgSprite.icon("family", "name")) ==
               "<svg fill=\"currentColor\"><use href=\"/images/family.svg#name\"></use></svg>"
    end

    test "with atoms as arguments, returns safe string " do
      assert safe_to_string(SvgSprite.icon(:family, :name)) ==
               "<svg fill=\"currentColor\"><use href=\"/images/family.svg#name\"></use></svg>"
    end

    test "with atoms and binary arguments, returns safe string" do
      assert safe_to_string(SvgSprite.icon(:family, "name")) ==
               "<svg fill=\"currentColor\"><use href=\"/images/family.svg#name\"></use></svg>"

      assert safe_to_string(SvgSprite.icon("family", :name)) ==
               "<svg fill=\"currentColor\"><use href=\"/images/family.svg#name\"></use></svg>"
    end
  end

  describe "test icon/3" do
    test "with class argument, returns safe string for the SVG element with class attribute" do
      assert safe_to_string(SvgSprite.icon(:family, :name, class: "w-5 h-5")) ==
               "<svg class=\"w-5 h-5\" fill=\"currentColor\"><use href=\"/images/family.svg#name\"></use></svg>"
    end

    test "with fill argument, returns safe string with changed fill attribute" do
      assert safe_to_string(SvgSprite.icon(:family, :name, fill: "red")) ==
               "<svg fill=\"red\"><use href=\"/images/family.svg#name\"></use></svg>"
    end
  end

  describe "test icon/2 in Font Awesome context" do
    test "with family short names, returns safe string with the correct sprite file reference" do
      assert safe_to_string(SvgSprite.icon(:fas, :name)) ==
               "<svg fill=\"currentColor\"><use href=\"/images/solid.svg#name\"></use></svg>"

      assert safe_to_string(SvgSprite.icon(:far, :name)) ==
               "<svg fill=\"currentColor\"><use href=\"/images/regular.svg#name\"></use></svg>"

      assert safe_to_string(SvgSprite.icon(:fab, :name)) ==
               "<svg fill=\"currentColor\"><use href=\"/images/brands.svg#name\"></use></svg>"

      assert safe_to_string(SvgSprite.icon(:fal, :name)) ==
               "<svg fill=\"currentColor\"><use href=\"/images/light.svg#name\"></use></svg>"

      assert safe_to_string(SvgSprite.icon(:fad, :name)) ==
               "<svg fill=\"currentColor\"><use href=\"/images/duotone.svg#name\"></use></svg>"
    end

    test "with fa-prefix on icon name, returns safe string with the prefix removed" do
      assert safe_to_string(SvgSprite.icon(:fas, "fa-coffee")) ==
               "<svg fill=\"currentColor\"><use href=\"/images/solid.svg#coffee\"></use></svg>"
    end
  end
end
