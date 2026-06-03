-- Yapılacaklar tablosu
create table if not exists public.todos (
  id          bigint generated always as identity primary key,
  text        text not null check (char_length(text) > 0),
  done        boolean not null default false,
  inserted_at timestamptz not null default now()
);

-- Row Level Security açık
alter table public.todos enable row level security;

-- NOT: Bu demo kimlik doğrulaması (auth) içermez. Aşağıdaki politikalar
-- anon (public anahtar) rolüne tam erişim verir; yani anon key'i bilen herkes
-- bu tabloyu okuyup yazabilir. Basit/kişisel bir demo için uygundur.
-- Gerçek bir uygulamada Supabase Auth ekleyip politikaları user_id'ye göre
-- kısıtlamalısın.

drop policy if exists "anon select" on public.todos;
drop policy if exists "anon insert" on public.todos;
drop policy if exists "anon update" on public.todos;
drop policy if exists "anon delete" on public.todos;

create policy "anon select" on public.todos
  for select to anon using (true);

create policy "anon insert" on public.todos
  for insert to anon with check (true);

create policy "anon update" on public.todos
  for update to anon using (true) with check (true);

create policy "anon delete" on public.todos
  for delete to anon using (true);
