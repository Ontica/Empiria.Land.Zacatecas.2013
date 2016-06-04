/* Empiria® Web Application 2012 *****************************************************************************
*																																																						 *
*	 Solution  : Empiria® Web Application                         System   : Workplace Web Pages               *
*	 Namespace : Empiria.Web.UI.Workplace                         Assembly : Empiria.Web.UI.dll                *
*	 Type      : OLDSecondaryMasterPage										          Pattern  : Master Web Page                   *
*	 Date      : 23/Oct/2012                                      Version  : 5.0      Pattern version: 2.0     *
*																																																						 *
*  Summary   : Gets user credentials and redirects users to the workplace start page.                        *
*																																																						 *
******************************************************** Copyright © La Vía Óntica, SC. México, 1994-2012. **/

using Empiria.Presentation.Web;
using Empiria.Presentation.Web.Content;

namespace Empiria.Web.UI.Workplace {

  public partial class OLDSecondaryMasterPage : MasterWebPage {

    #region Fields

    private MasterPageContent masterPageContent = null;

    #endregion Fields

    #region Protected properties

    protected MasterPageContent MasterPageContent {
      get {
        if (masterPageContent == null) {
          masterPageContent = new MasterPageContent(base.Page);
        }
        return masterPageContent;
      }
    }

    #endregion Protected properties

    #region Protected methods

    protected override void Initialize() {

    }

    protected override void LoadMasterPageControls() {

    }

    #endregion Protected methods

  } // class OLDSecondaryMasterPage

} // namespace Empiria.Web.UI.Workplace