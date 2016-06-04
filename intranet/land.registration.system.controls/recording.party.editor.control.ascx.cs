﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;

using Empiria.DataTypes;
using Empiria.Geography;
using Empiria.Government.LandRegistration;
using Empiria.Presentation.Web.Content;

namespace Empiria.Web.UI.LRS {

  public partial class RecordingPartyEditorControl : System.Web.UI.UserControl {

    #region Fields

    private RecordingAct recordingAct = null;
    private Party party = null;
    protected bool isLoaded = false;

    #endregion Fields

    #region Public properties

    public bool IsPartyInRecordingAct {
      get { return true; }
    }

    public Party Party {
      get { return party; }
      set { party = value; }
    }

    public RecordingAct RecordingAct {
      get { return recordingAct; }
      set { recordingAct = value; }
    }

    #endregion Public properties

    #region Public methods

    public void LoadEditor() {
      LoadMainCombos();
    }

    private void LoadMainCombos() {
      HtmlSelectContent.LoadCombo(this.cboOccupation, Occupation.GetList(), "Id", "Name",
                                  "( Seleccionar )", String.Empty, "No consta");

      HtmlSelectContent.LoadCombo(this.cboMarriageStatus, MarriageStatus.GetList(), "Id", "Name",
                                  "( ? )", String.Empty, "No consta");

      HtmlSelectContent.LoadCombo(cboBornLocation, "( Seleccionar lugar de nacimiento )",
                                  String.Empty, GeographicRegionItem.Unknown.Name);

      HtmlSelectContent.LoadCombo(cboAddressPlace, "( Seleccionar lugar de residencia )",
                                  String.Empty, GeographicRegionItem.Unknown.Name);

      ObjectList<RecordingActParty> parties = RecordingActParty.GetInvolvedDomainParties(this.recordingAct);

      LoadRolesCombo(parties);
      LoadFirstPartyInRoleCombo(parties);
    }

    private void LoadFirstPartyInRoleCombo(ObjectList<RecordingActParty> parties) {
      cboFirstPartyInRole.Items.Clear();
      parties.Sort((x, y) => x.Party.FullName.CompareTo(y.Party.FullName));

      cboFirstPartyInRole.Items.Add(new ListItem("( Seleccionar una persona u organización )", String.Empty));
      foreach (RecordingActParty item in parties) {
        if (item.Party.Equals(this.party)) {
          continue;
        }
        ListItem listItem = new ListItem(item.Party.FullName, item.Party.Id.ToString());
        if (!cboFirstPartyInRole.Items.Contains(listItem)) {
          cboFirstPartyInRole.Items.Add(listItem);
        }
      }

      parties = RecordingActParty.GetSecondaryPartiesList(this.recordingAct);

      parties.Sort((x, y) => x.SecondaryParty.FullName.CompareTo(y.SecondaryParty.FullName));
      foreach (RecordingActParty item in parties) {
        if (item.SecondaryParty.Equals(this.party)) {
          continue;
        }
        ListItem listItem = new ListItem(item.SecondaryParty.FullName, item.SecondaryParty.Id.ToString());
        if (!cboFirstPartyInRole.Items.Contains(listItem)) {
          cboFirstPartyInRole.Items.Add(listItem);
        }
      }
      if (cboFirstPartyInRole.Items.Count > 2) {
        cboFirstPartyInRole.Items.Add(new ListItem("( Selección múltiple )", "multiselect"));
      }
    }

    protected string GetMultiselectListItems(System.Web.UI.HtmlControls.HtmlSelect control, string controlName) {
      const string row = "<tr><td><input id='{CONTROL.ID}' name='{CONTROL.NAME}' type='checkbox' value='{ITEM.VALUE}' /></td>" +
                         "<td id='{ITEM.NAME.ID}' style='white-space:normal;width:98%'>{ITEM.NAME}</td></tr>";
      string html = String.Empty;
      foreach (ListItem item in control.Items) {
        if (EmpiriaString.IsInteger(item.Value) && (int.Parse(item.Value) > 0)) {
          string temp = row.Replace("{ITEM.VALUE}", item.Value);
          temp = temp.Replace("{ITEM.NAME}", item.Text);
          temp = temp.Replace("{ITEM.NAME.ID}", controlName + "_text_" + item.Value);
          temp = temp.Replace("{CONTROL.ID}", controlName + "_" + item.Value);
          temp = temp.Replace("{CONTROL.NAME}", controlName);
          html += temp;
        }
      }
      return html;
    }

    private void LoadRolesCombo(ObjectList<RecordingActParty> parties) {
      this.cboRole.Items.Clear();

      if (parties.Count == 0 || parties.Count((x) => x.OwnershipMode == OwnershipMode.Owner) == 0) {
        HtmlSelectContent.LoadCombo(this.cboRole, this.recordingAct.RecordingActType.GetRoles(), "Id", "Name", "( Seleccionar rol )");
      } else {
        HtmlSelectContent.LoadCombo(this.cboRole, "( Seleccionar rol )", String.Empty, String.Empty);
      }

      List<RecordingActParty> bareOwnersList = parties.FindAll((x) => x.OwnershipMode == OwnershipMode.Bare);
      if (bareOwnersList.Count != 0) {
        this.cboRole.Items.Add(new ListItem(DomainActPartyRole.Usufructuary.Name, DomainActPartyRole.Usufructuary.Id.ToString()));
        HtmlSelectContent.LoadCombo<RecordingActParty>(cboUsufructuaryOf, bareOwnersList, (x) => x.Party.Id.ToString(),
                                                       (x) => x.Party.FullName, "( Seleccionar al nudo propietario )");
        if (cboUsufructuaryOf.Items.Count > 2) {
          cboUsufructuaryOf.Items.Add(new ListItem("( Selección múltiple )", "multiselect"));
        }
      }

      this.cboRole.Items.Add(new ListItem("( Secundarios )", String.Empty));
      HtmlSelectContent.AppendToCombo(this.cboRole, PartiesRole.GetList(), "Id", "Name");
    }

    private Party FillOrganizationParty() {
      if (this.Party == null) {
        this.Party = OrganizationParty.Create(Ontology.ObjectTypeInfo.Parse(int.Parse(cboPartyType.Value)));
      }
      OrganizationParty org = (OrganizationParty) this.Party;

      org.FullName = txtOrgName.Value;
      org.Nicknames = txtOrgNicknames.Value;
      org.TaxIDNumber = txtOrgTaxIDNumber.Value;
      org.Notes = txtOrgRegistryText.Value;
      if (!String.IsNullOrEmpty(Request.Form[txtOrgRegistryDate.Name])) {
        org.RegistryDate = EmpiriaString.ToDateTime(txtOrgRegistryDate.Value);
      } else {
        org.RegistryDate = ExecutionServer.DateMaxValue;
      }
      if (!String.IsNullOrEmpty(Request.Form[cboOrgRegistryLocation.Name])) {
        org.RegistryLocation = GeographicRegionItem.Parse(int.Parse(Request.Form[cboOrgRegistryLocation.Name]));
      } else {
        org.RegistryLocation = GeographicRegionItem.Unknown;
      }
      org.Save();

      return org;
    }

    private Party FillHumanParty() {
      if (this.Party == null) {
        this.Party = new HumanParty();
      }
      HumanParty person = (HumanParty) this.Party;

      if (!String.IsNullOrEmpty(Request.Form[txtBornDate.Name])) {
        person.RegistryDate = EmpiriaString.ToDateTime(txtBornDate.Value);
      } else {
        person.RegistryDate = ExecutionServer.DateMaxValue;
      }
      if (!String.IsNullOrEmpty(Request.Form[cboBornLocation.Name])) {
        person.RegistryLocation = GeographicRegionItem.Parse(int.Parse(Request.Form[cboBornLocation.Name]));
      } else {
        person.RegistryLocation = GeographicRegionItem.Unknown;
      }
      person.CURPNumber = txtCURPNumber.Value;
      person.FirstFamilyName = txtFirstFamilyName.Value;
      person.FirstName = txtFirstName.Value;
      person.MaritalFamilyName = txtMaritalFamilyName.Value;
      person.Gender = (Contacts.Gender) Convert.ToChar(cboGender.Value);
      person.IFENumber = txtIFENumber.Value;
      person.Nicknames = txtNicknames.Value;
      person.SecondFamilyName = txtSecondFamilyName.Value;
      person.TaxIDNumber = txtTaxIDNumber.Value;

      person.Save();

      return person;
    }

    private void UpdateRecordingActParty(RecordingActParty rap) {
      rap.Notes = txtNotes.Value;
      rap.PartyAddress = txtAddress.Value;
      if (!String.IsNullOrEmpty(Request.Form[cboAddressPlace.Name])) {
        rap.PartyAddressPlace = GeographicRegionItem.Parse(int.Parse(Request.Form[cboAddressPlace.Name]));
      } else {
        rap.PartyAddressPlace = GeographicRegionItem.Unknown;
      }
      rap.PartyMarriageStatus = MarriageStatus.Parse(int.Parse(cboMarriageStatus.Value));
      rap.PartyOccupation = Occupation.Parse(int.Parse(cboOccupation.Value));

      rap.Save();
    }

    private void FillHumanPartyOnRecording() {
      ObjectList<RecordingActParty> list = RecordingActParty.GetList(this.RecordingAct.Recording, this.Party);
      foreach (RecordingActParty rap in list) {
        if ((rap.Party.Equals(this.Party) && rap.SecondaryParty.IsEmptyInstance) || rap.SecondaryParty.Equals(this.Party)) {
          UpdateRecordingActParty(rap);
        }
      }
    }

    private void LoadHumanParty() {
      HumanParty person = (HumanParty) this.Party;

      cboPartyType.Value = person.ObjectTypeInfo.Id.ToString();

      if (person.RegistryDate != ExecutionServer.DateMaxValue) {
        txtBornDate.Value = person.RegistryDate.ToString("dd/MMM/yyyy");
      } else {
        txtBornDate.Value = String.Empty;
      }
      txtFirstFamilyName.Value = person.FirstFamilyName;
      txtFirstName.Value = person.FirstName;
      txtMaritalFamilyName.Value = person.MaritalFamilyName;
      cboGender.Value = ((char) person.Gender).ToString();
      txtIFENumber.Value = person.IFENumber;
      txtCURPNumber.Value = person.CURPNumber;
      txtTaxIDNumber.Value = person.TaxIDNumber;
      txtNicknames.Value = person.Nicknames;
      txtSecondFamilyName.Value = person.SecondFamilyName;

      cboBornLocation.Items.Clear();
      cboBornLocation.Items.Add(new ListItem(person.RegistryLocation.CompoundName, person.RegistryLocation.Id.ToString()));

      ObjectList<RecordingActParty> list = RecordingActParty.GetList(this.RecordingAct.Recording, this.Party);
      List<RecordingActParty> p = list.FindAll((x) => (x.Party.Equals(this.Party) && x.SecondaryParty.IsEmptyInstance) || x.SecondaryParty.Equals(this.Party));

      RecordingActParty lastParty = null;
      if (p.Count != 0) {
        lastParty = p[0];
      } else {
        lastParty = person.GetLastRecordingActParty(this.recordingAct.Recording.PresentationTime);
      }
      if (lastParty == null) {
        isLoaded = true;
        return;
      }
      txtAddress.Value = lastParty.PartyAddress;
      cboAddressPlace.Items.Clear();
      cboAddressPlace.Items.Add(new ListItem(lastParty.PartyAddressPlace.CompoundName, lastParty.PartyAddressPlace.Id.ToString()));
      cboOccupation.Value = lastParty.PartyOccupation.Id.ToString();
      cboMarriageStatus.Value = lastParty.PartyMarriageStatus.Id.ToString();

      isLoaded = true;
    }

    private void LoadOrganizationParty() {
      OrganizationParty org = (OrganizationParty) this.Party;

      cboPartyType.Value = org.ObjectTypeInfo.Id.ToString();
      if (org.RegistryDate != ExecutionServer.DateMaxValue) {
        txtOrgRegistryDate.Value = org.RegistryDate.ToString("dd/MMM/yyyy");
      } else {
        txtOrgRegistryDate.Value = String.Empty;
      }
      txtOrgName.Value = org.FullName;
      txtOrgNicknames.Value = org.Nicknames;
      txtOrgRegistryText.Value = org.Notes;
      txtOrgTaxIDNumber.Value = org.TaxIDNumber;

      cboOrgRegistryLocation.Value = org.RegistryLocation.Id.ToString();
      isLoaded = true;
    }

    public void SelectParty(int partyId) {
      this.Party = Party.Parse(partyId);
      if (this.Party.ObjectTypeInfo.Id == 2433) {
        LoadHumanParty();
      } else {
        LoadOrganizationParty();
      }
      cboParty.Items.Clear();
      cboParty.Items.Add(new ListItem(this.Party.ExtendedName, this.Party.Id.ToString()));

      ObjectList<RecordingActParty> parties = RecordingActParty.GetInvolvedDomainParties(this.recordingAct);

      LoadRolesCombo(parties);
      LoadFirstPartyInRoleCombo(parties);
      LoadAdditionalRoleCombo();
    }

    private void LoadAdditionalRoleCombo() {
      System.Data.DataTable table =
          Empiria.Government.LandRegistration.Data.PropertyData.GetSecondaryParties(this.Party, this.RecordingAct);

      cboAdditionalRole.Items.Clear();
      if (table.Rows.Count > 0) {
        cboAdditionalRole.Items.Add(new ListItem("( Existen uno o más roles adicionales )", String.Empty));
      }
      for (int i = 0; i < table.Rows.Count; i++) {
        System.Data.DataRow row = table.Rows[i];
        string id = ((int) table.Rows[i]["PartyId"]).ToString() + "|" + ((int) table.Rows[i]["SecondaryPartyRoleId"]).ToString();
        string text = (string) row["SecondaryPartyRole"] + ": " + (string) row["PartyFullName"];

        cboAdditionalRole.Items.Add(new ListItem(text, id));
      }
    }

    public void SaveParty(int partyId) {
      this.Party = Party.Parse(partyId);
      if (this.Party.ObjectTypeInfo.Id == 2433) {
        this.Party = FillHumanParty();
        if (IsPartyInRecordingAct) {
          FillHumanPartyOnRecording();
        }
      } else {
        this.Party = FillOrganizationParty();
      }
    }

    public void SaveRecordingParty() {
      string selectedParty = Request.Form[cboParty.Name];
      if (String.IsNullOrWhiteSpace(selectedParty)) {
        //this.party = FillNewParty();
      } else if (selectedParty == "appendParty") {
        if (cboPartyType.Value == "2433") {
          this.party = FillHumanParty();
        } else {
          this.party = FillOrganizationParty();
        }
      } else {
        this.party = Party.Parse(int.Parse(selectedParty));
      }
      SaveRecordingActParty();
    }

    private void SaveRecordingActParty() {
      if (int.Parse(cboRole.Value) >= 1230) {
        SaveSecondaryRoleParty();
      } else if (int.Parse(cboRole.Value) == DomainActPartyRole.Usufructuary.Id) {
        SaveUsufructuaryRoleParty();
      } else {
        SaveDomainRoleParty();
      }
      SaveAdditionalRole();

    }

    private void FillPartyData(RecordingActParty rap) {
      if (this.party is HumanParty) {
        rap.Notes = txtNotes.Value;
        rap.PartyAddress = txtAddress.Value;
        if (!String.IsNullOrEmpty(Request.Form[cboAddressPlace.Name])) {
          rap.PartyAddressPlace = GeographicRegionItem.Parse(int.Parse(Request.Form[cboAddressPlace.Name]));
        } else {
          rap.PartyAddressPlace = GeographicRegionItem.Unknown;
        }
        if (!String.IsNullOrEmpty(Request.Form[cboMarriageStatus.Name])) {
          rap.PartyMarriageStatus = MarriageStatus.Parse(int.Parse(Request.Form[cboMarriageStatus.Name]));
        } else {
          rap.PartyMarriageStatus = MarriageStatus.Unknown;
        }
        if (!String.IsNullOrEmpty(Request.Form[cboOccupation.Name])) {
          rap.PartyOccupation = Occupation.Parse(int.Parse(Request.Form[cboOccupation.Name]));
        } else {
          rap.PartyOccupation = Occupation.Unknown;
        }
      }
    }

    private void SaveDomainRoleParty() {
      RecordingActParty rap = RecordingActParty.Create(this.RecordingAct, this.party);

      rap.PartyRole = DomainActPartyRole.Parse(int.Parse(cboRole.Value));
      rap.SecondaryPartyRole = PartiesRole.Empty;
      rap.SecondaryParty = HumanParty.Parse(-1);

      rap.OwnershipMode = (OwnershipMode) Convert.ToChar(cboOwnership.Value.Substring(0, 1));
      if (txtOwnershipPartAmount.Value.Length == 0) {
        txtOwnershipPartAmount.Value = "1.00";
      }
      rap.OwnershipPart = Quantity.Parse(DataTypes.Unit.Parse(cboOwnershipPartUnit.Value),
                                         decimal.Parse(txtOwnershipPartAmount.Value));
      FillPartyData(rap);

      rap.Save();
    }

    private void SaveSecondaryRoleParty() {
      string[] selectedParties = null;
      if (cboFirstPartyInRole.Value == "multiselect") {
        selectedParties = hdnMultiPartiesInRole.Value.Split('|');
      } else {
        selectedParties = new string[] { cboFirstPartyInRole.Value };
      }
      foreach (string selectedParty in selectedParties) {
        RecordingActParty rap = RecordingActParty.Create(this.RecordingAct, Party.Parse(int.Parse(selectedParty)));
        rap.PartyRole = DomainActPartyRole.Empty;
        rap.SecondaryPartyRole = PartiesRole.Parse(int.Parse(cboRole.Value));
        rap.SecondaryParty = this.party;

        FillPartyData(rap);

        rap.Save();
      }
    }

    private void SaveAdditionalRole() {
      if (cboAdditionalRole.Value.Length == 0) {
        return;
      }
      int partyId = int.Parse(cboAdditionalRole.Value.Split('|')[0]);
      int roleId = int.Parse(cboAdditionalRole.Value.Split('|')[1]);

      RecordingActParty rap = RecordingActParty.Create(this.RecordingAct, this.party);
      rap.PartyRole = DomainActPartyRole.Empty;
      rap.SecondaryPartyRole = PartiesRole.Parse(roleId);
      rap.SecondaryParty = Party.Parse(partyId);

      rap.Save();
    }

    private void SaveUsufructuaryRoleParty() {
      string[] selectedParties = null;
      if (cboUsufructuaryOf.Value == "multiselect") {
        selectedParties = hdnMultiPartiesInRole.Value.Split('|');
      } else {
        selectedParties = new string[] { cboUsufructuaryOf.Value };
      }
      foreach (string selectedParty in selectedParties) {
        RecordingActParty rap = RecordingActParty.Create(this.RecordingAct, this.party);
        rap.UsufructMode = (UsufructMode) Convert.ToChar(cboUsufruct.Value.Substring(0, 1));
        if (txtUsufructPartAmount.Value.Length == 0) {
          txtUsufructPartAmount.Value = "1.00";
        }
        rap.OwnershipPart = Quantity.Parse(DataTypes.Unit.Parse(cboUsufructPartUnit.Value),
                                           decimal.Parse(txtUsufructPartAmount.Value));
        rap.UsufructTerm = txtUsufructEndCondition.Value;
        rap.PartyRole = DomainActPartyRole.Usufructuary;
        rap.SecondaryPartyRole = PartiesRole.Empty;
        rap.SecondaryParty = Party.Parse(int.Parse(selectedParty));

        FillPartyData(rap);

        rap.Save();
      }

    }

    #endregion Public methods

  } // class RecordingPartyEditorControl

} // namespace Empiria.Web.UI.LRS