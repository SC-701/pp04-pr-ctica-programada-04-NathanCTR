using Microsoft.AspNetCore.Authentication.Cookies;

using Autorizacion.Abstracciones.DA;
using Autorizacion.Abstracciones.Flujo;
using Autorizacion.DA;
using Autorizacion.Flujo;
using Autorizacion.Middleware;


using Reglas;
using Abstracciones.Interfaces.Reglas;

var builder = WebApplication.CreateBuilder(args);


builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(options =>
    {
        options.LoginPath = "/Seguridad/Login";
        options.LogoutPath = "/Seguridad/Logout";
        options.AccessDeniedPath = "/Seguridad/Acceso";
        options.ExpireTimeSpan = TimeSpan.FromMinutes(120);
    });

builder.Services.AddTransient<IAutorizacionFlujo, AutorizacionFlujo>();
builder.Services.AddTransient<ISeguridadDA, SeguridadDA>();
builder.Services.AddTransient<IRepositorioDapper, RepositorioDapper>();
builder.Services.AddScoped<IConfiguracion, Configuracion>();


// Add services to the container.
builder.Services.AddRazorPages();
var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.MapRazorPages(); 

app.Run();

app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();

app.MapRazorPages();