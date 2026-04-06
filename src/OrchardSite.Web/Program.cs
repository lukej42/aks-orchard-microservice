var builder = WebApplication.CreateBuilder(args);

// 1. Add Orchard Core CMS services
builder.Services.AddOrchardCms();

var app = builder.Build();

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

// 2. Routing and Orchard Pipeline
app.UseRouting();

// enables Multi-Tenancy
app.UseOrchardCore();

app.Run();