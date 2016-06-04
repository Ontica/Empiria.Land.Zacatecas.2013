using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Empiria.Government.LandRegistration.Data;
using Empiria.Government.LandRegistration.Transactions;

namespace EmpiriaWeb.Government.LandRegistration.Controllers {

  [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
  public class HomeController : Controller {
    //
    // GET: /Home/
    public ActionResult Index() {
      return View();
    }

    // GET: /Home/GetLRSTransaction
    public JsonResult GetLRSTransaction(string transactionNumber) {
      LRSTransaction o = LRSTransaction.ParseWithNumber(transactionNumber);

      if (o == null) {
        return null;
      }
      var result = new {
        Id = o.Id.ToString(),
        Key = o.Key,
        RequestedBy = o.RequestedBy,
        Type = o.TransactionType.Name,
        DocumentType = o.DocumentType.Name,
        RecorderOffice = o.RecorderOffice.Alias,
        PresentationTime = o.PresentationTime.ToString("dd/MMM/yyyy HH:mm:ss"),
        ClosingTime = o.ClosingTime.ToString("dd/MMM/yyyy HH:mm"),
        ReceiptTotal = o.ReceiptTotal.ToString("C2"),
        StatusName = LRSTransaction.StatusName(o.Status),
        DeliveryEstimatedDate = GetDeliveryEstimatedDate(o)
      };

      return base.Json(result, JsonRequestBehavior.AllowGet);
    } // GetLRSTransaction

    // GET: /Home/GetParties
    public JsonResult GetParties(string name) {
      List<PartyIndexData> list = IndexesData.FindParty(name, String.Empty);

      return base.Json(list, JsonRequestBehavior.AllowGet);
    }

    private string GetDeliveryEstimatedDate(LRSTransaction transaction) {
      if (transaction == null) {
        return "Trámite desconocido o no encontrado";
      }
      if (transaction.Status == TransactionStatus.Delivered) {
        return transaction.ClosingTime.ToString("dd/MMM/yyyy");
      }
      if (transaction.Status == TransactionStatus.ToDeliver || transaction.Status == TransactionStatus.ToReturn) {
        return "Listo para entregarse";
      }
      return "No determinada";
    }  // GetDeliveryEstimatedDate

  }  // class HomeController

}  // namespace EmpiriaWeb.Government.LandRegistration.Controllers 
