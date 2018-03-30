using System.Web;
using System.Web.Optimization;

namespace HomeShareMVC
{
    public class BundleConfig
    {
        // For more information on bundling, visit https://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.validate*"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at https://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/bootstrap.js",
                      "~/Scripts/owl.carousel.js",
                      "~/Scripts/respond.js"));
            bundles.Add(new ScriptBundle("~/bundles/slitslider").Include(
                      "~/Scripts/slitslider/jquery.ba-cond.min.js",
                      "~/Scripts/slitslider/jquery.slitslider.js",
                      "~/Scripts/slitslider/modernizr.custom.79639.js"
                      ));


            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/bootstrap.css",
                      "~/Content/owl.carousel.css",
                      "~/Content/owl.theme.css",
                      "~/Content/site.css"));
            bundles.Add(new StyleBundle("~/Content/slitslider").Include(
                      "~/Content/slitslider/custom.css",
                      "~/Content/slitslider/style.css"
                     ));
        }
    }
}
