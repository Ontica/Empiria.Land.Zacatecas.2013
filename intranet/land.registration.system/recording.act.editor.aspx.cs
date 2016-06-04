/* Empiria® Web Application 2012 *****************************************************************************
*																																																						 *
*	 Solution  : Empiria® Web Application                         System   : Workplace Web Pages               *
*	 Namespace : Empiria.Web.UI                                   Assembly : Empiria.Web.UI.dll                *
*	 Type      : ObjectSearcher                                   Pattern  : Explorer Web Page                 *
*	 Date      : 23/Oct/2012                                      Version  : 5.0      Pattern version: 2.0     *
*																																																						 *
*  Summary   : Gets user credentials and redirects users to the workplace start page.                        *
*																																																						 *
******************************************************** Copyright © La Vía Óntica, SC. México, 1994-2012. **/
using System;
using System.Web.UI.WebControls;
using Empiria.Government.LandRegistration;
using Empiria.Government.LandRegistration.UI;
using Empiria.Presentation.Web;

namespace Empiria.Web.UI.LRS {

  public partial class RecordingActEditor : WebPage {

    #region Fields

    protected RecordingAct recordingAct = null;
    private bool showFirstPropertyOwner = true;

    #endregion Fields

    #region Protected methods

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
      if (IsPostBack) {
        DoCommand();
      } else {
        LoadControls();
      }
    }

    #endregion Protected methods

    #region Private methods

    protected bool DisplayFirstPropertyOwner {
      get {
        if (recordingAct.RecordingActType.Name.StartsWith("ObjectType.RecordingAct.AnnotationAct")) {
          return false;
        }
        return showFirstPropertyOwner;
      }
    }

    private void DoCommand() {
      switch (base.CommandName) {
        case "saveRecordingAct":
          SaveRecordingAct();
          Response.Redirect("recording.act.editor.aspx?id=" + recordingAct.Id.ToString(), true);
          return;
        case "saveRecordingActAsComplete":
          SaveRecordingActAsComplete();
          Response.Redirect("recording.act.editor.aspx?id=" + recordingAct.Id.ToString(), true);
          return;
        case "saveParty":
          SaveParty();
          return;
        case "selectParty":
          SelectParty();
          return;
        case "appendParty":
          AppendParty();
          Response.Redirect("recording.act.editor.aspx?id=" + recordingAct.Id.ToString(), true);
          return;
        case "deleteParty":
          DeleteParty();
          Response.Redirect("recording.act.editor.aspx?id=" + recordingAct.Id.ToString(), true);
          return;
        default:
          throw new NotImplementedException(base.CommandName);
      }
    }

    private void AppendParty() {
      oPartyEditorControl.SaveRecordingParty();
    }

    private void DeleteParty() {
      int partyId = int.Parse(base.GetCommandParameter("partyId"));
      RecordingActParty party = RecordingActParty.Parse(partyId);
      party.Delete();
    }

    private void SaveParty() {
      int partyId = int.Parse(base.GetCommandParameter("partyId"));
      oPartyEditorControl.SaveParty(partyId);
      oPartyEditorControl.SelectParty(partyId);
    }

    private void SelectParty() {
      int partyId = int.Parse(base.GetCommandParameter("partyId"));
      oPartyEditorControl.SelectParty(partyId);

      this.oAntecedentParties.BaseRecordingAct = this.recordingAct;
      this.oAntecedentParties.Property = Property.Parse(int.Parse(cboProperty.Value));
    }

    protected string GetRecordingActPartiesGrid() {
      return LRSGridControls.GetRecordingActPartiesGrid(this.recordingAct, false);
    }

    private void SaveRecordingAct() {
      oRecordingActAttributes.FillRecordingAct();
      recordingAct.Notes = txtObservations.Value;
      recordingAct.Status = (RecordingActStatus) Convert.ToChar(cboStatus.Value);
      recordingAct.Save();
      if (this.DisplayFirstPropertyOwner) {
        recordingAct.SetFirstPropertyOwner(txtFirstPropertyOwner.Value);
      }
    }

    private void SaveRecordingActAsComplete() {
      recordingAct.Status = RecordingActStatus.Registered;
      recordingAct.Save();
    }

    private void Initialize() {
      recordingAct = RecordingAct.Parse(int.Parse(Request.QueryString["id"]));
      showFirstPropertyOwner = recordingAct.RecordingActType.UseFirstPropertyOwner;
      oRecordingActAttributes.RecordingAct = this.recordingAct;
      oPartyEditorControl.RecordingAct = this.recordingAct;

      this.oAntecedentParties.BaseRecordingAct = this.recordingAct;
    }

    private void LoadControls() {
      txtRecordingActName.Value = "(" + recordingAct.Index.ToString("00") + ") " + recordingAct.RecordingActType.DisplayName;
      txtObservations.Value = recordingAct.Notes;
      cboStatus.Value = ((char) recordingAct.Status).ToString();
      FillPropertiesCombo();
      if (this.recordingAct.RecordingActType.Name.StartsWith("ObjectType.RecordingAct.DomainAct")) {
        this.oAntecedentParties.BaseRecordingAct = this.recordingAct;
        this.oAntecedentParties.Property = Property.Parse(int.Parse(cboProperty.Value));
      } else {
        this.oAntecedentParties.Visible = false;
      }
      oPartyEditorControl.LoadEditor();
      oRecordingActAttributes.LoadRecordingAct();

      this.lastOwnerRow.Visible = this.DisplayFirstPropertyOwner;
    }

    private void FillPropertiesCombo() {
      this.oAntecedentParties.Visible = false;
      cboProperty.Items.Clear();
      for (int i = 0; i < recordingAct.PropertiesEvents.Count; i++) {
        Property property = recordingAct.PropertiesEvents[i].Property;
        if (property.IsFirstRecordingAct(recordingAct)) {
          txtFirstPropertyOwner.Value = property.FirstKnownOwner;
        } else {
          showFirstPropertyOwner = false;
          this.oAntecedentParties.Visible = true;
        }
        cboProperty.Items.Add(new ListItem(property.TractKey, property.Id.ToString()));
      }
    }

    #endregion Private methods

  } // class PropertyEditor

} // namespace Empiria.Web.UI.LRS