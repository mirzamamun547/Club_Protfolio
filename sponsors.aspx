<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sponsors.aspx.cs" Inherits="KBC.sponsors" MasterPageFile="~/Site.Master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
  Sponsors | KBC Official
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <link rel="stylesheet" href="advisor.css">
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <section class="advisors-hero">
    <div class="container">
      <div class="advisors-hero-content reveal">
        <p class="eyebrow">Our Partners</p>
        <h1>Meet Our Sponsors</h1>
        <p>Discover the incredible organizations and companies that support KBEC in fostering innovation and entrepreneurship.</p>
      </div>
    </div>
  </section>

  <section class="section section-advisors-full">
    <div class="container">
      <div class="advisors-grid-full reveal">
        <asp:Repeater ID="rptSponsors" runat="server">
          <ItemTemplate>
            <article class="advisor-card-full"
              style='background-image: linear-gradient(135deg, rgba(15, 23, 42, 0.9) 0%, rgba(15, 23, 42, 0.7) 100%), url(<%# ResolveUrl(string.IsNullOrEmpty(Eval("PhotoPath").ToString()) ? "~/images/default-sponsor.png" : Eval("PhotoPath").ToString()) %>); background-size: cover; background-position: center;'>
              <div class="advisor-info" style="display: flex; flex-direction: column; align-items: center; text-align: center;">
                <div style="background: white; padding: 15px; border-radius: 12px; margin-bottom: 20px; box-shadow: 0 10px 20px rgba(0,0,0,0.2);">
                    <img src='<%# ResolveUrl(Eval("PhotoPath").ToString()) %>' alt="Sponsor Logo" style="max-height: 80px; width: auto; object-fit: contain; border-radius: 4px;" onerror="this.src='images/default-sponsor.png'" />
                </div>
                <h3><%# Eval("Name") %></h3>
                <p class="advisor-expertise" style="margin-top: 10px; max-width: 90%;"><%# Eval("Description") %></p>
              </div>
            </article>
          </ItemTemplate>
        </asp:Repeater>
      </div>
    </div>
  </section>
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
