using System;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using CursosCertificadosApp.Data;

var options = new DbContextOptionsBuilder<AppDbContext>()
    .UseNpgsql("Host=localhost;Port=5432;Database=cursos_globales_jp;Username=postgres;Password=admin123")
    .Options;

using var ctx = new AppDbContext(options);
var courses = ctx.Courses
    .Include(c => c.Category)
    .Include(c => c.Modules)
    .Include(c => c.Quizzes).ThenInclude(q => q.Questions)
    .OrderBy(c => c.Id)
    .ToList();

Console.WriteLine($"TOTAL COURSES: {courses.Count}");
foreach(var c in courses) {
    var qCount = c.Quizzes.FirstOrDefault()?.Questions.Count ?? 0;
    Console.WriteLine($"ID: {c.Id} | Slug: {c.Slug} | Modules: {c.Modules.Count} | QuizQuestions: {qCount} | Title: {c.Title}");
}
